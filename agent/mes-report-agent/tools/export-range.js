#!/usr/bin/env node
/** export-range.js — 从本地 worklog 提取区间日志 + 任务池全量，供汇报生成
 *
 * 用法:
 *   node agent/mes-report-agent/tools/export-range.js 2026-08-03 2026-08-09
 *   （止日期可省略，默认 = 起日期）
 *
 * 输出:
 *   ① 区间日志清单（按所属项目分组，含日期/结果类型）
 *   ② 任务池全量（按优先级排序，含状态/计划完成日期）
 */
'use strict';
const fs = require('fs');
const path = require('path');

const WORKLOG = path.join(__dirname, '..', 'data', 'worklog');
const LOGS_DIR = path.join(WORKLOG, 'logs');
const TASK_FILE = path.join(WORKLOG, 'task-pool.json');

const start = process.argv[2];
const end = process.argv[3] || start;
if (!/^\d{4}-\d{2}-\d{2}$/.test(start) || !/^\d{4}-\d{2}-\d{2}$/.test(end)) {
  console.error('用法: node export-range.js <起始日期 YYYY-MM-DD> <截止日期 YYYY-MM-DD>');
  process.exit(1);
}
if (start > end) { console.error('起始日期不能晚于截止日期'); process.exit(1); }

const P_ORDER = { 'P1': 0, 'P2': 1, 'P3': 2, 'P4': 3 };

// 读全量日志（遍历 logs/*.json，按日期过滤）
const logs = [];
if (fs.existsSync(LOGS_DIR)) {
  for (const f of fs.readdirSync(LOGS_DIR)) {
    if (!f.endsWith('.json')) continue;
    const arr = JSON.parse(fs.readFileSync(path.join(LOGS_DIR, f), 'utf8'));
    for (const rec of arr) {
      const d = rec['记录日期'] || '';
      if (d >= start && d <= end) logs.push(rec);
    }
  }
}
logs.sort((a, b) => (a['记录日期'] || '').localeCompare(b['记录日期'] || ''));

// 读任务池全量
const tasks = fs.existsSync(TASK_FILE) ? JSON.parse(fs.readFileSync(TASK_FILE, 'utf8')) : [];
tasks.sort((a, b) => {
  const pa = P_ORDER[a['优先级']] ?? 9, pb = P_ORDER[b['优先级']] ?? 9;
  if (pa !== pb) return pa - pb;
  return (a['发现日期'] || '').localeCompare(b['发现日期'] || '');
});

console.log('==================================================');
console.log(` 区间 ${start} ~ ${end} · 日志 ${logs.length} 条 / 任务池 ${tasks.length} 条`);
console.log('==================================================');

console.log('\n【一、区间日志】');
const byProject = {};
for (const r of logs) {
  const p = r['所属项目'] || '未归类';
  if (!byProject[p]) byProject[p] = [];
  byProject[p].push(r);
}
for (const [proj, arr] of Object.entries(byProject)) {
  console.log(`\n── ${proj}（${arr.length} 条）`);
  for (const r of arr) {
    const t = r['记录日期'] || '?';
    const rt = r['结果类型'] ? `[${r['结果类型']}]` : '';
    const mk = r['业务模块'] ? `(${r['业务模块']})` : '';
    const content = (r['工作内容'] || '').replace(/\n/g, ' ');
    console.log(`  ${t} ${rt}${mk} ${content}`);
  }
}

console.log('\n\n【二、任务池全量】');
for (const t of tasks) {
  const pri = (t['优先级'] || '?').padEnd(3);
  const st = (t['任务状态'] || '?').padEnd(4);
  const due = t['计划完成日期'] ? `(计划 ${t['计划完成日期']})` : '';
  const wk = t['周报归集分类'] ? `[${t['周报归集分类']}]` : '';
  console.log(`${pri} ${st} ${t['对应项目'] || '?'} ${wk} ${t['归集标题']} ${due}`);
}

console.log('\n【三、P1/P2 未闭环风险】');
const open = tasks.filter(t => !['已闭环'].includes(t['任务状态']) && ['P1', 'P2'].includes(t['优先级']));
for (const t of open) {
  console.log(`- [${t['优先级']}] ${t['对应项目']} ${t['归集标题']}（${t['任务状态']}${t['计划完成日期'] ? '，计划 ' + t['计划完成日期'] : ''}）`);
}
console.log(`  ${open.length} 项未闭环`);
