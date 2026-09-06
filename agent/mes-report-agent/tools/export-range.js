#!/usr/bin/env node
/** export-range.js — 本地 worklog 周报/月报数据包（区间蒸馏，默认≈几K token）
 *
 * 职责：一次调用吐出写周报所需的全部蒸馏事实，杜绝"整段打印卡点历史"式探测。
 *
 * 用法：
 *   node agent/mes-report-agent/tools/export-range.js 2026-08-31 2026-09-04
 *   node agent/mes-report-agent/tools/export-range.js 2026-08-31 2026-09-04 --todos   # 追加未闭环任务清单(P3/P4/待启动/暂缓)
 *   node agent/mes-report-agent/tools/export-range.js 2026-08-31 2026-09-04 --all      # 旧行为：任务池全量(含已闭环)回显
 *   node agent/mes-report-agent/tools/export-range.js 2026-08-31 2026-09-04 --project=三厂小簧sMES
 *
 * 输出段：
 *   ① 区间日志（按项目分组，含日期/结果类型）          —— 完成事项/叙述佐证
 *   ② 任务池·窗口变化（新增/闭环/卡点更新+尾注）        —— "本周动态"唯一权威口径
 *   ③ 项目状态快照（各项目 进行中/待启动/暂缓/已闭环）   —— 待办计数
 *   ④ P1/P2 未闭环风险（含卡点末段原因，≤130字）       —— 风险叙述
 *   ⑤ 未闭环任务清单（--todos 时输出，行精简：P级/状态/进度%/标题）
 *
 * 数据结构契约见 data/worklog/SCHEMA.md（本脚本字段名与之一致）。
 */
'use strict';
const fs = require('fs');
const path = require('path');

const WORKLOG = path.join(__dirname, '..', 'data', 'worklog');
const LOGS_DIR = path.join(WORKLOG, 'logs');
const TASK_FILE = path.join(WORKLOG, 'task-pool.json');

// ---------- 参数 ----------
const args = process.argv.slice(2).filter(a => !a.startsWith('--'));
const flags = new Set(process.argv.slice(2).filter(a => a.startsWith('--')).map(a => a.split('=')[0]));
const flagVal = (name, def) => {
  const a = process.argv.slice(2).find(x => x.startsWith(name + '='));
  return a ? a.split('=')[1] : def;
};
const start = args[0], end = args[1] || start;
const wantTodos = flags.has('--todos'), wantAll = flags.has('--all');
const projectFilter = flagVal('--project', null);
if (!/^\d{4}-\d{2}-\d{2}$/.test(start) || !/^\d{4}-\d{2}-\d{2}$/.test(end) || start > end) {
  console.error('用法: node export-range.js <起始 YYYY-MM-DD> <截止 YYYY-MM-DD> [--todos|--all] [--project=名]');
  process.exit(1);
}
const winY = +start.slice(0, 4);
const today = new Date();
const todayStr = `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, '0')}-${String(today.getDate()).padStart(2, '0')}`;

// ---------- 读取 ----------
const logs = [];
if (fs.existsSync(LOGS_DIR)) {
  for (const f of fs.readdirSync(LOGS_DIR)) {
    if (!f.endsWith('.json')) continue;
    const arr = JSON.parse(fs.readFileSync(path.join(LOGS_DIR, f), 'utf8'));
    for (const rec of arr) {
      const d = rec['记录日期'] || '';
      if (d >= start && d <= end && (!projectFilter || rec['所属项目'] === projectFilter)) logs.push(rec);
    }
  }
}
logs.sort((a, b) => (a['记录日期'] || '').localeCompare(b['记录日期'] || ''));
const tasks = fs.existsSync(TASK_FILE) ? JSON.parse(fs.readFileSync(TASK_FILE, 'utf8')) : [];
const proj = t => t['对应项目'] || '?';
const logProj = r => r['所属项目'] || '未归类';   // 日志用"所属项目"，任务用"对应项目"
const pri = t => t['优先级'] || 'P?';
const pct = t => { const v = String(t['进度百分比'] ?? '').replace(/[%％]/g, ''); return v ? v + '%' : ''; };
const note = t => t['卡点&问题描述'] || '';

// ---------- 卡点更新标记解析 ----------
// 标记形态：【8-31/9-1更新】【9-4待办清单更新】【9-5更新】…（年份省略、可能复合日期）
// 解析整个卡点串 → 标记列表 [{d:'YYYY-MM-DD', label, seg(该标记后续文本至下一标记或尾), pos}]
function parseMarkers(text, winStart, winEnd) {
  const out = [];
  const re = /【([^】]{1,24})】/g;
  let m;
  while ((m = re.exec(text)) !== null) {
    const body = m[1];
    const pairs = [];
    let p;
    const pre = /(\d{1,2})[-/](\d{1,2})/g;
    while ((p = pre.exec(body)) !== null) pairs.push([+p[1], +p[2]]);
    if (!pairs.length) continue;
    // 年解析：同一 m-d 可能指今年(winY)或去年(winY-1)。
    // 规则：winY 拼出且 ≤ 今天 → 今年；否则 → winY-1（去年的真实事件/或今年未到的未来标注，统一落去年避免误判窗口内）
    // 局限：去年 9 月之前的旧任务若又带同形未来标注会歧义，见 data/worklog/SCHEMA.md 注
    const dates = pairs.map(([mm, dd]) => {
      const f = `${winY}-${String(mm).padStart(2, '0')}-${String(dd).padStart(2, '0')}`;
      return (f <= todayStr) ? f : `${winY - 1}-${String(mm).padStart(2, '0')}-${String(dd).padStart(2, '0')}`;
    });
    // 复合标记(如【8-31/9-1更新】)天然产出多条、同位同段 —— 直接各记一条即可
    for (const d of dates) out.push({ d, pos: m.index });
  }
  // 给每个"标记起点"分配文本段（同位重复点合并，段取至下一不同标记位）
  const posUniq = [...new Set(out.map(k => k.pos))].sort((a, b) => a - b);
  posUniq.push(text.length);
  out.forEach(mk => { mk.seg = text.slice(mk.pos, posUniq[posUniq.indexOf(mk.pos) + 1]); });
  return out;
}
const inWin = d => d >= start && d <= end;
const lastSegLe = (text, segs, limit = 130) => {
  const last = segs.filter(s => s.d <= end).sort((a, b) => a.d.localeCompare(b.d)).pop();
  if (!last) return '';
  return (last.seg || '').replace(/\s+/g, ' ').slice(0, limit);
};

const byId = new Map(tasks.map(t => [t['_id'], t]));
const S = { '已闭环': 0, '进行中': 1, '待启动': 2, '暂缓': 3 };

// ---------- 输出 ----------
console.log(`区间 ${start} ~ ${end} · 日志 ${logs.length} 条 / 任务池 ${tasks.length} 条（${start} 起状态快照）`);

// ① 日志
console.log('\n【① 区间日志】');
const byProject = {};
for (const r of logs) { (byProject[logProj(r)] = byProject[logProj(r)] || []).push(r); }
if (!logs.length) console.log('（窗口内无日志）');
for (const [p, arr] of Object.entries(byProject)) {
  console.log(`\n── ${p}（${arr.length} 条）`);
  for (const r of arr) {
    const rt = r['结果类型'] ? `[${r['结果类型']}]` : '';
    console.log(`  ${r['记录日期']} ${rt} ${(r['工作内容'] || '').replace(/\s+/g, ' ').slice(0, 140)}`);
  }
}

// ② 窗口变化
console.log('\n【② 任务池·窗口变化】');
const newly = tasks.filter(t => (t['发现日期'] || '') >= start && (t['发现日期'] || '') <= end);
const closed = tasks.filter(t => (t['实际闭环日期'] || '') >= start && (t['实际闭环日期'] || '') <= end);
const touched = tasks.map(t => ({ t, mks: parseMarkers(note(t), start, end) }));
const updated = touched
  .filter(({ mks }) => mks.some(mk => inWin(mk.d)))
  .map(({ t, mks }) => ({ t, mks }))
  .sort((a, b) => (b.t['_id'] || '').localeCompare(a.t['_id'] || ''));
if (!newly.length && !closed.length && !updated.length) console.log('（窗口内无任务增删改）');
if (newly.length) {
  console.log('\n· 窗口内新发现：');
  for (const t of newly) console.log(`  + ${t['_id']} ${pri(t)} ${proj(t)} ${t['归集标题']}｜${t['任务状态']} ${pct(t)}｜发现${t['发现日期']}`);
}
if (closed.length) {
  console.log('\n· 窗口内闭环：');
  for (const t of closed) console.log(`  ✓ ${t['_id']} ${pri(t)} ${proj(t)} ${t['归集标题']}｜闭环${t['实际闭环日期']}`);
}
const updIds = new Set(updated.map(u => u.t['_id']));
console.log('\n· 窗口内卡点更新（取最新窗口内标记起算，≤240字；⚠=其后另有窗口外更新）：');
for (const { t, mks } of updated) {
  const lastIn = mks.filter(mk => inWin(mk.d)).sort((a, b) => a.d.localeCompare(b.d)).pop();
  const later = [...new Set(mks.filter(mk => mk.d > end).map(x => x.d.slice(5)))];
  const tail = note(t).slice(lastIn.pos).replace(/\s+/g, ' ').slice(0, 240);
  const future = later.length ? ` ⚠窗后更新:${later.join('/')}` : '';
  console.log(`  - ${t['_id']} ${pri(t)} [${proj(t)}] ${t['任务状态']} ${pct(t)} ${t['归集标题']}`);
  console.log(`    「${tail}」${future}`);
}

// ③ 项目状态快照
console.log('\n【③ 项目状态快照】');
const agg = {};
for (const t of tasks) {
  const p = proj(t);
  const st = t['任务状态'] || '?';
  const o = (agg[p] = agg[p] || { total: 0, '进行中': 0, '待启动': 0, '暂缓': 0, '已闭环': 0 });
  o.total++;
  if (st in o) o[st]++;
}
const tot = { total: tasks.length, '进行中': 0, '待启动': 0, '暂缓': 0, '已闭环': 0 };
for (const [p, o] of Object.entries(agg)) {
  tot['进行中'] += o['进行中']; tot['待启动'] += o['待启动']; tot['暂缓'] += o['暂缓']; tot['已闭环'] += o['已闭环'];
  if (!wantAll && o.total === o['已闭环']) continue; // 纯闭环项目跳过(默认)
  console.log(`  ${p} 共${o.total} · 进行中${o['进行中']} 待启动${o['待启动']} 暂缓${o['暂缓']} 已闭环${o['已闭环']}`);
}
console.log(`  ── 合计 共${tot.total} · 进行中${tot['进行中']} 待启动${tot['待启动']} 暂缓${tot['暂缓']} 已闭环${tot['已闭环']}`);

// ④ P1/P2 未闭环风险（含卡点末段原因）
console.log('\n【④ P1/P2 未闭环风险】');
const open = tasks.filter(t => !['已闭环'].includes(t['任务状态']) && ['P1', 'P2'].includes(pri(t)));
const P_ORDER = { 'P1': 0, 'P2': 1 };
open.sort((a, b) => (P_ORDER[pri(a)] ?? 2) - (P_ORDER[pri(b)] ?? 2) || (proj(a) < proj(b) ? -1 : 1));
for (const t of open) {
  const mk = t['_id'];
  console.log(`  - ${pri(t)} ${proj(t)} ${t['归集标题']}｜${t['任务状态']} ${pct(t)}｜计划${t['计划完成日期'] || '—'}｜${mk}`);
  // ② 已给出该任务完整窗口尾注 → ④ 不再重复原因，只在无窗口更新时补一行末段
  if (!updIds.has(mk)) {
    const cause = lastSegLe(note(t), parseMarkers(note(t), start, end), 130);
    if (cause) console.log(`    因: ${cause}`);
  }
}
if (!open.length) console.log('  （无）');

// ⑤ 未闭环任务清单（--todos）
if (wantTodos) {
  console.log('\n【⑤ 未闭环任务清单（--todos）】');
  const shownIds = new Set(open.map(t => t['_id']));
  const rest = tasks
    .filter(t => !['已闭环'].includes(t['任务状态']) && !shownIds.has(t['_id']))
    .sort((a, b) => proj(a).localeCompare(proj(b)) || (S[a['任务状态']] ?? 9) - (S[b['任务状态']] ?? 9));
  let lastProj = null;
  for (const t of rest) {
    if (t['对应项目'] !== lastProj) { lastProj = t['对应项目']; console.log(`\n── ${lastProj || '?'}`); }
    console.log(`  ${pri(t)} ${t['任务状态']} ${pct(t)} ${t['归集标题']}`);
  }
  if (!rest.length) console.log('  （无）');
}

// ⑥ --all 旧行为全量回显
if (wantAll) {
  console.log('\n【⑥ 任务池全量（--all）】');
  const byP = {};
  for (const t of tasks) { const p = proj(t); (byP[p] = byP[p] || []).push(t); }
  const P = { 'P1': 0, 'P2': 1, 'P3': 2, 'P4': 3 };
  for (const [p, arr] of Object.entries(byP)) {
    console.log(`\n── ${p}（${arr.length}）`);
    arr.sort((a, b) => (P[pri(a)] ?? 9) - (P[pri(b)] ?? 9));
    for (const t of arr) console.log(`  ${pri(t)} ${t['任务状态']} ${pct(t)} ${t['归集标题']}｜${t['_id']}`);
  }
}
