#!/usr/bin/env node
/**
 * weekly-extract.js — MES 项目周报数据提取（workflow V1）
 *
 * 职责：从「任务问题归集池」+「原始工作日志」两个 CSV 中，
 *      按报告期（年/周）+ 可选项目，提取周报素材并按四模块预分组。
 *
 * 用法：
 *   node tools/weekly-extract.js --year 2026 --week 32
 *   node tools/weekly-extract.js --year 2026 --week 32 --project 三厂小簧sMES
 *
 * 参数：
 *   --year   报告年份（默认当年）
 *   --week   ISO 周次（默认当周）
 *   --project 可选：单项目周报，否则全项目汇总
 *   --tasks  任务池 CSV 路径（默认 data/task-pool-supplement.csv）
 *   --logs   日志 CSV 路径（默认 data/history-log-governance.csv）
 *   --out    输出路径（默认 tmp/weekly-input-<year>-W<week>.md）
 *
 * 输出：结构化 markdown（四模块预分组 + 本周日志佐证），供 prompt 生成周报。
 */
'use strict';

const fs = require('fs');
const path = require('path');

// ---------- 参数解析 ----------
function parseArgs(argv) {
  const args = {};
  for (let i = 2; i < argv.length; i++) {
    const a = argv[i];
    if (a.startsWith('--')) {
      const key = a.slice(2);
      const val = argv[i + 1] && !argv[i + 1].startsWith('--') ? argv[i + 1] : true;
      args[key] = val;
      if (val !== true) i++;
    }
  }
  return args;
}

// ---------- ISO 周换算 ----------
// 返回某年某 ISO 周的周一日期
function isoWeekStart(year, week) {
  // 1月4日必在第一周
  const jan4 = new Date(year, 0, 4);
  const jan4Day = (jan4.getDay() + 6) % 7; // 周一=0
  const week1Start = new Date(year, 0, 4 - jan4Day);
  const start = new Date(week1Start.getFullYear(), week1Start.getMonth(), week1Start.getDate() + (week - 1) * 7);
  return start;
}
function addDays(d, n) {
  return new Date(d.getFullYear(), d.getMonth(), d.getDate() + n);
}
function fmt(d) {
  return `${d.getFullYear()}-${d.getMonth() + 1}-${d.getDate()}`;
}
// 解析 "2026-6-22" 或 "2026/6/22" 为 Date
function parseDate(s) {
  if (!s) return null;
  const m = String(s).match(/(\d{4})[-/](\d{1,2})[-/](\d{1,2})/);
  if (!m) return null;
  return new Date(+m[1], +m[2] - 1, +m[3]);
}

// ---------- CSV 解析（简单版，含引号） ----------
function parseCSV(text) {
  const rows = [];
  let row = [], field = '', inQ = false;
  for (let i = 0; i < text.length; i++) {
    const ch = text[i];
    if (inQ) {
      if (ch === '"') {
        if (text[i + 1] === '"') { field += '"'; i++; }
        else inQ = false;
      } else field += ch;
    } else if (ch === '"') {
      inQ = true;
    } else if (ch === ',') {
      row.push(field); field = '';
    } else if (ch === '\n') {
      row.push(field);
      if (row.some(c => c.trim() !== '')) rows.push(row);
      row = []; field = '';
    } else if (ch !== '\r') {
      field += ch;
    }
  }
  row.push(field);
  if (row.some(c => c.trim() !== '')) rows.push(row);
  return rows;
}
function csvToObjects(csvPath) {
  const text = fs.readFileSync(csvPath, 'utf8');
  const rows = parseCSV(text);
  if (!rows.length) return [];
  const headers = rows[0].map(h => h.trim());
  return rows.slice(1).map(r => {
    const o = {};
    headers.forEach((h, i) => { o[h] = (r[i] || '').trim(); });
    return o;
  });
}

// ---------- 主逻辑 ----------
const args = parseArgs(process.argv);
const now = new Date();
const year = +args.year || now.getFullYear();
const week = +args.week || (() => {
  // 当前 ISO 周（简单近似）
  const start = new Date(now.getFullYear(), 0, 1);
  return Math.ceil(((now - start) / 86400000 + start.getDay() + 1) / 7);
})();
const project = args.project ? String(args.project) : null;

const baseDir = path.join(__dirname, '..');
const repoRoot = path.join(baseDir, '..', '..');
const tasksPath = args.tasks ? args.tasks : path.join(baseDir, 'data', 'task-pool-supplement.csv');
const logsPath = args.logs ? args.logs : path.join(baseDir, 'data', 'history-log-governance.csv');

const weekStart = isoWeekStart(year, week);
const weekEnd = addDays(weekStart, 6);

// 读取任务池
const tasks = fs.existsSync(tasksPath) ? csvToObjects(tasksPath) : [];
// 读取日志
const logs = fs.existsSync(logsPath) ? csvToObjects(logsPath) : [];

// ---------- 四模块预分组（任务池为主） ----------
const done = [];        // 本周完成事项
const risks = [];       // 核心问题及风险
const todos = [];       // 待办事项
const nextPlan = [];    // 下周重点计划

function inRange(t) {
  return t >= weekStart && t <= weekEnd;
}

tasks.forEach(t => {
  const proj = t.project || '';
  if (project && proj !== project) return;
  const status = t.status || '';
  const pri = t.priority || '';
  const cat = t.weekly_category || '';
  const discover = parseDate(t.discover_date);
  const plan = parseDate(t.plan_date);

  if (status === '已闭环' || cat === '本周完成') {
    done.push(t);
  } else if ((pri === 'P1' || pri === 'P2') && status !== '已闭环') {
    risks.push(t);
  }
  if (status === '待启动' || status === '进行中' || status === '暂缓') {
    if (status !== '已闭环') todos.push(t);
  }
  if (cat === '下周计划' || (plan && inRange(addDays(plan, 0)) && plan > weekEnd)) {
    nextPlan.push(t);
  }
});

// 去重：一个任务可能进多个模块，这里保留（AI 组织时取舍）
// 本周日志（过程佐证）
const weekLogs = logs.filter(l => {
  const d = parseDate(l.date);
  if (!d || !inRange(d)) return false;
  if (project) {
    return (l.target_project || '') === project;
  }
  return true;
});
// 日志的项目用 target_project（治理后的归属）
const weekLogsByProj = {};
weekLogs.forEach(l => {
  const p = l.target_project || '未归类';
  (weekLogsByProj[p] = weekLogsByProj[p] || []).push(l);
});

// ---------- 输出 markdown ----------
const P = project ? project : '全项目';
let out = `# ${P} · 2026年第${week}周 MES项目周报（数据素材）

> 报告期：${fmt(weekStart)} ~ ${fmt(weekEnd)}（第${week}周）
> 生成时间：${fmt(now)} · 来源：任务问题归集池（主）+ 原始工作日志（过程佐证）

## 一、本周完成事项（${done.length} 条）
`;
if (!done.length) out += '\n（本周暂无闭环任务）\n';
done.forEach(t => {
  out += `- [${t.priority || ''}] ${t.title || ''}｜项目:${t.project || ''}｜闭环:${t.close_criteria || '—'}\n`;
});

out += `\n## 二、核心问题及风险（${risks.length} 条）\n`;
if (!risks.length) out += '\n（无 P1/P2 未闭环风险）\n';
risks.forEach(t => {
  out += `- [${t.priority}] ${t.title}｜状态:${t.status || ''}｜发现:${t.discover_date || '—'}｜计划:${t.plan_date || '—'}｜来源:${t.source || '—'}\n`;
  if (t.resource_needed) out += `  - 需协调：${t.resource_needed}\n`;
});

out += `\n## 三、待办事项（${todos.length} 条）\n`;
if (!todos.length) out += '\n（无进行中/待启动任务）\n';
todos.forEach(t => {
  out += `- [${t.priority || ''}] ${t.title || ''}｜状态:${t.status || ''}｜计划完成:${t.plan_date || '—'}｜进度:${t.progress || t.progress_percent || '—'}\n`;
});

out += `\n## 四、下周重点计划（${nextPlan.length} 条）\n`;
if (!nextPlan.length) out += '\n（下周计划任务未标记）\n';
nextPlan.forEach(t => {
  out += `- ${t.title || ''}｜计划:${t.plan_date || '—'}｜分类:${t.weekly_category || '—'}\n`;
});

out += `\n## 五、本周原始日志佐证（${weekLogs.length} 条）\n`;
if (!weekLogs.length) {
  out += '\n（本周无日志记录）\n';
} else {
  Object.keys(weekLogsByProj).forEach(p => {
    out += `\n### ${p}\n`;
    weekLogsByProj[p].forEach(l => {
      out += `- ${l.date}｜${(l.content_preview || '').replace(/\|/g, '｜')}\n`;
    });
  });
}

// ---------- 写入输出 ----------
const outPath = args.out || path.join(repoRoot, 'tmp', `weekly-input-${year}-W${week}${project ? '-' + project : ''}.md`);
fs.mkdirSync(path.dirname(outPath), { recursive: true });
fs.writeFileSync(outPath, out, 'utf8');
console.log('✅ 周报素材已生成: ' + outPath);
console.log(`   任务池 ${tasks.length} 条｜本周日志 ${weekLogs.length} 条｜完成${done.length} 风险${risks.length} 待办${todos.length} 下周${nextPlan.length}`);
