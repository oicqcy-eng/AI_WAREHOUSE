#!/usr/bin/env node
/** worklog-append.js — 本地工作日志追加工具（替代飞书 API 写入）
 *
 * 用法:
 *   node agent/mes-report-agent/tools/worklog-append.js log '<json>'     # 追加日志（写 logs/YYYY-MM.json）
 *   node agent/mes-report-agent/tools/worklog-append.js task '<json>'    # 追加任务（写 task-pool.json）
 *   node agent/mes-report-agent/tools/worklog-append.js update-log '<{_id,...}>'   # 更新日志
 *   node agent/mes-report-agent/tools/worklog-append.js update-task '<{_id,...}>'  # 更新任务
 *   node agent/mes-report-agent/tools/worklog-append.js delete-log '<{_id}>'       # 删除日志
 *   node agent/mes-report-agent/tools/worklog-append.js delete-task '<{_id}>'      # 删除任务
 *
 * 日志必填: 记录日期(YYYY-MM-DD) 所属项目 工作内容 结果类型 是否形成任务
 * 任务必填: 归集标题 对应项目 问题来源 优先级
 * 缺省值策略: report-bitable-spec.md §4.4（结果类型=需求确认 优先级=P4 任务状态=待启动
 *             是否形成任务=否 业务模块=系统管理 项目阶段=需求调研 日期=今天）
 */
'use strict';
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

const WORKLOG = path.join(__dirname, '..', 'data', 'worklog');
const WORKLOG_DIR = WORKLOG; // 供 server 静态服务附件用
const LOGS_DIR = path.join(WORKLOG, 'logs');
const TASK_FILE = path.join(WORKLOG, 'task-pool.json');

const TODAY = (() => { const d = new Date(); const p = n => String(n).padStart(2, '0'); return d.getFullYear() + '-' + p(d.getMonth() + 1) + '-' + p(d.getDate()); })();

// 默认值（缺省取最低档）
const LOG_DEFAULTS = {
  '结果类型': '需求确认', '是否形成任务': '否', '业务模块': '系统管理',
  '项目阶段': '需求调研', '责任人': '陈宇', '协作人': '', '交付产出': '',
};
const TASK_DEFAULTS = {
  '问题来源': '会议决策', '任务状态': '待启动', '周报归集分类': '长期跟踪',
  '发现日期': TODAY, '计划完成日期': '', '实际闭环日期': '', '进度百分比': '',
  '闭环判定标准': '', '协调资源需求': '', '卡点&问题描述': '',
};

// 稳定 _id：date+content+idx 哈希，确定性（同一条记录永远同一个 id）
function makeId(prefix, rec, idx) {
  const key = rec['记录日期'] || rec['发现日期'] || rec['归集标题'] || rec['工作内容'] || '';
  const content = rec['工作内容'] || rec['归集标题'] || '';
  return prefix + '-' + crypto.createHash('sha1').update(key + '|' + content + '|' + idx).digest('hex').slice(0, 10);
}
function ensureId(rec, prefix, idx) {
  if (!rec['_id']) rec['_id'] = makeId(prefix, rec, idx);
  return rec['_id'];
}

function loadJson(file, fallback) {
  try { return JSON.parse(fs.readFileSync(file, 'utf8')); }
  catch (e) { return fallback; }
}
function saveJson(file, data) {
  fs.mkdirSync(path.dirname(file), { recursive: true });
  fs.writeFileSync(file, JSON.stringify(data, null, 2) + '\n', 'utf8');
}

function appendLog(rec) {
  // 必填校验（契约与 schema 共用 LOG_REQUIRED，防漂移）
  for (const k of LOG_REQUIRED) {
    if (!rec[k]) throw new Error('日志缺少必填字段: ' + k);
  }
  // 日期格式校验
  if (!/^\d{4}-\d{2}-\d{2}$/.test(rec['记录日期'])) throw new Error('记录日期格式应为 YYYY-MM-DD: ' + rec['记录日期']);
  // 补缺省
  for (const k of Object.keys(LOG_DEFAULTS)) if (!(k in rec) || rec[k] === '') rec[k] = LOG_DEFAULTS[k];

  const month = rec['记录日期'].slice(0, 7);
  const file = path.join(LOGS_DIR, month + '.json');
  const arr = loadJson(file, []);
  ensureId(rec, 'L', arr.length);
  arr.push(rec);
  // 按日期排序（稳定保持同日期插入顺序）
  arr.sort((a, b) => (a['记录日期'] || '').localeCompare(b['记录日期'] || ''));
  saveJson(file, arr);
  return { file, total: arr.length, _id: rec['_id'] };
}

function appendTask(rec) {
  // 必填校验（契约与 schema 共用 TASK_REQUIRED，防漂移）
  for (const k of TASK_REQUIRED) {
    if (!rec[k]) throw new Error('任务缺少必填字段: ' + k);
  }
  // 补缺省
  for (const k of Object.keys(TASK_DEFAULTS)) if (!(k in rec) || rec[k] === '') rec[k] = TASK_DEFAULTS[k];

  const arr = loadJson(TASK_FILE, []);
  ensureId(rec, 'T', arr.length);
  arr.push(rec);
  // 按发现日期排序
  arr.sort((a, b) => (a['发现日期'] || '').localeCompare(b['发现日期'] || ''));
  saveJson(TASK_FILE, arr);
  return { file: TASK_FILE, total: arr.length, _id: rec['_id'] };
}

// ---------- 更新（按 _id 精确匹配覆盖；日志支持跨月移动） ----------
function findLogIndex(recs, id) {
  return recs.findIndex(r => r['_id'] === id || (r['_id'] === undefined && makeId('L', r, recs.indexOf(r)) === id));
}
function findTaskIndex(recs, id) {
  return recs.findIndex(r => r['_id'] === id || (r['_id'] === undefined && makeId('T', r, recs.indexOf(r)) === id));
}

function updateLog(id, patch) {
  if (!id) throw new Error('缺少 _id');
  // 旧记录定位：先全量扫描所有月份文件
  let found = null, foundFile = null, foundIdx = -1;
  for (const f of fs.readdirSync(LOGS_DIR)) {
    if (!f.endsWith('.json')) continue;
    const file = path.join(LOGS_DIR, f);
    const arr = loadJson(file, []);
    const i = findLogIndex(arr, id);
    if (i !== -1) { found = arr[i]; foundFile = file; foundIdx = i; break; }
  }
  if (!found) throw new Error('未找到 _id=' + id + ' 的日志记录');

  // 合并 patch：保留原记录字段，patch 覆盖（部分字段更新也安全，不会抹掉未传字段）
  const merged = Object.assign({}, found, patch);
  merged['_id'] = found['_id'];
  // 若 _id 缺失则保留旧 _id（patch 里可能不带）
  // 补缺省（与 append 一致，避免编辑后必填项意外被清空）
  for (const k of Object.keys(LOG_DEFAULTS)) if (!(k in merged) || merged[k] === '') merged[k] = LOG_DEFAULTS[k];
  if (!/^\d{4}-\d{2}-\d{2}$/.test(merged['记录日期'])) throw new Error('记录日期格式应为 YYYY-MM-DD: ' + merged['记录日期']);

  // 跨月移动：新月份文件 ≠ 旧月份文件
  const newMonth = merged['记录日期'].slice(0, 7);
  const newFile = path.join(LOGS_DIR, newMonth + '.json');
  if (newFile !== foundFile) {
    const oldArr = loadJson(foundFile, []);
    oldArr.splice(foundIdx, 1);
    saveJson(foundFile, oldArr);
    const newArr = loadJson(newFile, []);
    newArr.push(merged);
    newArr.sort((a, b) => (a['记录日期'] || '').localeCompare(b['记录日期'] || ''));
    saveJson(newFile, newArr);
    return { moved: true, file: newFile, total: newArr.length };
  }
  // 同月：直接替换
  const arr = loadJson(foundFile, []);
  arr[foundIdx] = merged;
  arr.sort((a, b) => (a['记录日期'] || '').localeCompare(b['记录日期'] || ''));
  saveJson(foundFile, arr);
  return { moved: false, file: foundFile, total: arr.length };
}

function updateTask(id, patch) {
  if (!id) throw new Error('缺少 _id');
  const arr = loadJson(TASK_FILE, []);
  const i = findTaskIndex(arr, id);
  if (i === -1) throw new Error('未找到 _id=' + id + ' 的任务记录');
  const merged = Object.assign({}, arr[i], patch); // 保留原字段，patch 覆盖（不抹掉未传字段）
  merged['_id'] = arr[i]['_id'];
  for (const k of Object.keys(TASK_DEFAULTS)) if (!(k in merged) || merged[k] === '') merged[k] = TASK_DEFAULTS[k];
  arr[i] = merged;
  arr.sort((a, b) => (a['发现日期'] || '').localeCompare(b['发现日期'] || ''));
  saveJson(TASK_FILE, arr);
  return { file: TASK_FILE, total: arr.length };
}

// ---------- 删除（按 _id 精确匹配移除；日志跨月文件扫描） ----------
function deleteLog(id) {
  if (!id) throw new Error('缺少 _id');
  if (!fs.existsSync(LOGS_DIR)) throw new Error('未找到 _id=' + id + ' 的日志记录');
  for (const f of fs.readdirSync(LOGS_DIR)) {
    if (!f.endsWith('.json')) continue;
    const file = path.join(LOGS_DIR, f);
    const arr = loadJson(file, []);
    const i = findLogIndex(arr, id);
    if (i !== -1) {
      arr.splice(i, 1);
      saveJson(file, arr);
      return { deleted: true, file, total: arr.length };
    }
  }
  throw new Error('未找到 _id=' + id + ' 的日志记录');
}

function deleteTask(id) {
  if (!id) throw new Error('缺少 _id');
  const arr = loadJson(TASK_FILE, []);
  const i = findTaskIndex(arr, id);
  if (i === -1) throw new Error('未找到 _id=' + id + ' 的任务记录');
  arr.splice(i, 1);
  saveJson(TASK_FILE, arr);
  return { deleted: true, file: TASK_FILE, total: arr.length };
}

// ---------- 按 id 取单条（供编辑回填） ----------
function findLog(id) {
  if (!fs.existsSync(LOGS_DIR)) return null;
  for (const f of fs.readdirSync(LOGS_DIR)) {
    if (!f.endsWith('.json')) continue;
    const arr = loadJson(path.join(LOGS_DIR, f), []);
    const i = findLogIndex(arr, id);
    if (i !== -1) return { rec: arr[i], file: path.join(LOGS_DIR, f) };
  }
  return null;
}
function findTask(id) {
  const arr = loadJson(TASK_FILE, []);
  const i = findTaskIndex(arr, id);
  return i === -1 ? null : { rec: arr[i], file: TASK_FILE };
}

// ---------- 只读辅助：schema 契约 / 按关键词找任务（供投喂前查字段、查关联任务用） ----------
const LOG_FIELDS = ['记录日期', '所属项目', '工作内容', '结果类型', '是否形成任务', '业务模块', '项目阶段', '责任人', '关联任务', '协作人', '交付产出']; // 规范序（不含 _id）
const LOG_REQUIRED = ['记录日期', '所属项目', '工作内容', '结果类型', '是否形成任务'];
const TASK_FIELDS = ['归集标题', '对应项目', '问题来源', '优先级', '发现日期', '计划完成日期', '实际闭环日期', '任务状态', '进度百分比', '闭环判定标准', '周报归集分类', '协调资源需求', '卡点&问题描述']; // 规范序（不含 _id）
const TASK_REQUIRED = ['归集标题', '对应项目', '问题来源', '优先级'];

function printSchema() {
  // 结果类型：spec(report-bitable-spec.md §表1) 定义 8 项；实测日志另出现 4 项扩展词
  const RT_SPEC = ['需求确认', '方案确认', '风险暴露', '数据完成', '培训完成', '配置完成', '上线验证', '问题关闭'];
  const RT_EXTRA = ['数据完善', '会议纪要', '数据修正', '知识沉淀'];
  const fmt = (list, defs) => list.map(k => {
    const tag = LOG_REQUIRED.includes(k) || TASK_REQUIRED.includes(k) ? '必填' : '选填';
    const d = defs && (k in defs) && defs[k] !== '' ? ('  默认: ' + defs[k]) : '';
    return '  ' + k + (tag === '必填' ? ' *必填' : '') + d;
  }).join('\n');
  return [
    '=== worklog schema ===',
    '【日志 log】追加 → logs/YYYY-MM.json',
    fmt(LOG_FIELDS, LOG_DEFAULTS),
    '【任务 task】追加 → task-pool.json（_id 用 update-task 关联/推进）',
    fmt(TASK_FIELDS, TASK_DEFAULTS),
    '【结果类型词表】spec 定义: ' + RT_SPEC.join(' / '),
    '实测扩展(数据中已用, spec 未列): ' + RT_EXTRA.join(' / '),
    '缺省档取最低档(详见 report-bitable-spec.md §4.4)；字段解读优先级=先解读上下文→拿不准问用户→才落缺省',
    '_id 自动生成(哈希); update-* 为部分字段合并(传什么改什么, 其余保留); delete 按 _id 精确',
    '=== 结束 ===',
  ].join('\n');
}

function searchTasks(kw, opts) {
  const arr = loadJson(TASK_FILE, []);
  const kwL = String(kw).toLowerCase();
  // 命中：归集标题 / 对应项目 / 卡点&问题描述 / _id
  const hit = arr.filter(t => [t['归集标题'], t['对应项目'], t['卡点&问题描述'], t['_id']].some(v => String(v || '').toLowerCase().includes(kwL)));
  const sortW = { '已闭环': 9, '': 3 }; // 未闭环/无状态优先，闭环沉底
  hit.sort((a, b) => (sortW[a['任务状态']] ?? 2) - (sortW[b['任务状态']] ?? 2) || (a['发现日期'] || '').localeCompare(b['发现日期'] || ''));
  const lines = hit.slice(0, opts && opts.limit ? opts.limit : 12).map(t => [
    t['_id'],
    '[' + (t['任务状态'] || '无状态') + (t['优先级'] ? ' P' + t['优先级'].replace('P', '') : '') + ']',
    (t['对应项目'] || ''), '|', (t['归集标题'] || '').slice(0, 60),
    t['进度百分比'] ? '(' + t['进度百分比'] + ')' : '',
  ].join(' '));
  return { total: hit.length, shown: lines.length, lines, query: kw };
}

// ---------- 导出（供 worklog-server.js / Claude 工具复用） ----------
module.exports = { appendLog, appendTask, updateLog, updateTask, deleteLog, deleteTask, findLog, findTask, searchTasks, printSchema, loadJson, saveJson, makeId, LOG_DEFAULTS, TASK_DEFAULTS, LOG_FIELDS, LOG_REQUIRED, TASK_FIELDS, TASK_REQUIRED, LOGS_DIR, TASK_FILE, WORKLOG_DIR, TODAY };

// ---------- CLI 入口 ----------
if (require.main === module) {
  const mode = process.argv[2];
  const jsonArg = process.argv[3];

  // 只读辅助：schema（打印字段契约）/ search-task（按关键词找关联任务）
  if (mode === 'schema') { console.log(printSchema()); process.exit(0); }
  if (mode === 'search-task') {
    if (!jsonArg) { console.error('用法: node worklog-append.js search-task \'<关键词>\''); process.exit(1); }
    const r = searchTasks(jsonArg);
    console.log('命中 ' + r.total + ' 条任务' + (r.total > r.shown ? '（仅显示前 ' + r.shown + '）' : '') + "，关键词: '" + r.query + "'");
    r.lines.forEach(l => console.log('  ' + l));
    process.exit(0);
  }

  if (!mode || !jsonArg) {
    console.error('用法: node worklog-append.js log|task|update-log|update-task|delete-log|delete-task \'<json>\'');
    console.error('  或: node worklog-append.js schema | search-task \'<关键词>\'');
    process.exit(1);
  }
  let rec;
  try { rec = JSON.parse(jsonArg); }
  catch (e) { console.error('❌ JSON 解析失败: ' + e.message); process.exit(1); }

  try {
    if (mode === 'log') {
      const r = appendLog(rec);
      console.log('✅ 日志已追加 → ' + path.relative(process.cwd(), r.file) + '（当前 ' + r.total + ' 条，_id=' + r._id + '）');
    } else if (mode === 'task') {
      const r = appendTask(rec);
      console.log('✅ 任务已追加 → ' + path.relative(process.cwd(), r.file) + '（当前 ' + r.total + ' 条，_id=' + r._id + '）');
    } else if (mode === 'update-log') {
      if (!rec['_id']) { console.error('❌ update-log 需要 _id'); process.exit(1); }
      const r = updateLog(rec['_id'], rec);
      console.log('✅ 日志已更新' + (r.moved ? '（跨月移动）' : '') + ' → ' + path.relative(process.cwd(), r.file) + '（当前 ' + r.total + ' 条）');
    } else if (mode === 'update-task') {
      if (!rec['_id']) { console.error('❌ update-task 需要 _id'); process.exit(1); }
      const r = updateTask(rec['_id'], rec);
      console.log('✅ 任务已更新 → ' + path.relative(process.cwd(), r.file) + '（当前 ' + r.total + ' 条）');
    } else if (mode === 'delete-log') {
      if (!rec['_id']) { console.error('❌ delete-log 需要 _id'); process.exit(1); }
      const r = deleteLog(rec['_id']);
      console.log('🗑️ 日志已删除 → ' + path.relative(process.cwd(), r.file) + '（剩余 ' + r.total + ' 条）');
    } else if (mode === 'delete-task') {
      if (!rec['_id']) { console.error('❌ delete-task 需要 _id'); process.exit(1); }
      const r = deleteTask(rec['_id']);
      console.log('🗑️ 任务已删除 → ' + path.relative(process.cwd(), r.file) + '（剩余 ' + r.total + ' 条）');
    } else {
      console.error('❌ 模式必须为 log / task / update-log / update-task / delete-log / delete-task'); process.exit(1);
    }
  } catch (e) {
    console.error('❌ ' + e.message); process.exit(1);
  }
}
