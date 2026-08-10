#!/usr/bin/env node
/** export-excel.js — 把本地 worklog 导出为 Excel(.xlsx)，随时可发给别人 / WPS 打开
 *
 * 用法:
 *   node agent/mes-report-agent/tools/export-excel.js log              → 原始工作日志.xlsx（全部日志）
 *   node agent/mes-report-agent/tools/export-excel.js task             → 任务问题归集池.xlsx（全部任务）
 *   node agent/mes-report-agent/tools/export-excel.js all              → 工作记录_全量.xlsx（两个 sheet）
 *
 * 可选筛选（在模式后追加）:
 *   --project=实验室Lims项目   只导出该项目
 *   --month=2026-08            只导出该月份（日志按记录日期；任务按发现日期）
 *   --out=自定义路径.xlsx       指定输出文件
 *
 * 例:
 *   node export-excel.js log --project=实验室Lims项目 --month=2026-08 --out=tmp/Lims八月.xlsx
 *   node export-excel.js all
 *
 * 依赖: xlsx 库（tmp/node_modules 已安装）。运行需 NODE_PATH=/d/AI_WAREHOUSE/tmp/node_modules
 *       或从 tmp/ 目录运行（node ../agent/.../export-excel.js）。
 */
'use strict';
const fs = require('fs');
const path = require('path');
const XLSX = require('xlsx');

const WORKLOG = path.join(__dirname, '..', 'data', 'worklog');
const LOGS_DIR = path.join(WORKLOG, 'logs');
const TASK_FILE = path.join(WORKLOG, 'task-pool.json');
const OUT_DIR = path.join(__dirname, '..', '..', '..', 'delivery', 'projects', 'hw-spring-mes', 'output');

const LOG_HEADERS = ['记录日期', '所属项目', '工作内容', '结果类型', '是否形成任务', '业务模块', '项目阶段', '责任人', '协作人', '交付产出'];
const TASK_HEADERS = ['归集标题', '对应项目', '问题来源', '优先级', '发现日期', '计划完成日期', '实际闭环日期', '任务状态', '进度百分比', '闭环判定标准', '周报归集分类', '协调资源需求', '卡点&问题描述'];

function parseArgs() {
  const mode = process.argv[2];
  const opts = { project: null, month: null, out: null };
  for (const a of process.argv.slice(3)) {
    const m = a.match(/^--(\w+)=(.*)$/);
    if (m) opts[m[1]] = m[2];
  }
  if (!['log', 'task', 'all'].includes(mode)) {
    console.error('用法: node export-excel.js log|task|all [--project=X] [--month=YYYY-MM] [--out=path.xlsx]');
    process.exit(1);
  }
  return { mode, opts };
}

function readLogs() {
  const all = [];
  if (fs.existsSync(LOGS_DIR)) {
    for (const f of fs.readdirSync(LOGS_DIR)) {
      if (!f.endsWith('.json')) continue;
      all.push(...JSON.parse(fs.readFileSync(path.join(LOGS_DIR, f), 'utf8')));
    }
  }
  return all;
}
function readTasks() {
  return fs.existsSync(TASK_FILE) ? JSON.parse(fs.readFileSync(TASK_FILE, 'utf8')) : [];
}

function filter(recs, opts, dateField) {
  return recs.filter(r => {
    if (opts.project && r['所属项目'] !== opts.project && r['对应项目'] !== opts.project) return false;
    if (opts.month && (r[dateField] || '').slice(0, 7) !== opts.month) return false;
    return true;
  });
}

function toSheet(recs, headers, dateFields) {
  const rows = recs.map(r => {
    const o = {};
    for (const h of headers) {
      let v = r[h] ?? '';
      // 进度百分比转成整数百分比显示（若为 0~1 小数）
      if (h === '进度百分比' && v !== '' && !isNaN(Number(v)) && Number(v) <= 1) {
        v = Math.round(Number(v) * 100) + '%';
      }
      o[h] = v;
    }
    return o;
  });
  const ws = XLSX.utils.json_to_sheet(rows, { header: headers });
  // 列宽
  ws['!cols'] = headers.map(h => {
    const widths = {
      '工作内容': 60, '归集标题': 50, '闭环判定标准': 40, '卡点&问题描述': 40, '协调资源需求': 30, '所属项目': 14, '对应项目': 14,
    };
    return { wch: widths[h] || 12 };
  });
  return ws;
}

const { mode, opts } = parseArgs();
const outFile = opts.out || (mode === 'log' ? '原始工作日志.xlsx' : mode === 'task' ? '任务问题归集池.xlsx' : '工作记录_全量.xlsx');
const outPath = path.resolve(outFile);

const wb = XLSX.utils.book_new();
if (mode === 'log' || mode === 'all') {
  const recs = filter(readLogs(), opts, '记录日期');
  const ws = toSheet(recs, LOG_HEADERS, ['记录日期']);
  XLSX.utils.book_append_sheet(wb, ws, '原始工作日志');
  console.log(`📄 日志 sheet: ${recs.length} 条${opts.project ? '（' + opts.project + '）' : ''}${opts.month ? '（' + opts.month + '）' : ''}`);
}
if (mode === 'task' || mode === 'all') {
  const recs = filter(readTasks(), opts, '发现日期');
  const ws = toSheet(recs, TASK_HEADERS, ['发现日期', '计划完成日期', '实际闭环日期']);
  XLSX.utils.book_append_sheet(wb, ws, '任务问题归集池');
  console.log(`📄 任务 sheet: ${recs.length} 条${opts.project ? '（' + opts.project + '）' : ''}${opts.month ? '（' + opts.month + '）' : ''}`);
}

fs.mkdirSync(path.dirname(outPath), { recursive: true });
XLSX.writeFile(wb, outPath);
console.log('✅ 已导出 → ' + path.relative(process.cwd(), outPath));
