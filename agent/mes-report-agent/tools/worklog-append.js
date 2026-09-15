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
 *   node agent/mes-report-agent/tools/worklog-append.js validate [--detail|--json] # 全量契约校验（只读）
 *
 * 日志必填: 记录日期(YYYY-MM-DD) 所属项目 工作内容 结果类型 是否形成任务
 * 任务必填: 归集标题 对应项目 问题来源 优先级
 *
 * 契约真源 = worklog-schema.js（枚举/字段清单/缺省值/校验器）。改契约改那里，不在本文件。
 * 缺省值: 仅「排序/分组归位」类字段有缺省；结果类型/业务模块/项目阶段 无缺省——
 *         它们须当场判定，留空优于伪造（2026-09-11 拍板，见 worklog-schema.js LOG_DEFAULTS 注释）
 * 校验: 三类（枚举成员性 / _id 规范性 / 关联任务引用存在性），模式由 WORKLOG_ENUM_MODE 控制
 *       （warn 默认：告警放行；strict：抛错阻断）
 */
'use strict';
const fs = require('fs');
const path = require('path');

// 契约真源 —— 本文件不再自定义枚举/字段/缺省值，只负责读写与校验调用
const S = require('./worklog-schema.js');
const {
  OPTIONS, OUTSIDERS, RESULT_TYPES_EXTRA,
  LOG_DEFAULTS, TASK_DEFAULTS, LOG_FIELDS, LOG_REQUIRED, TASK_FIELDS, TASK_REQUIRED,
  TODAY, makeId, validateRecord, missingRequired, requiredMessage, resolveMode, applyValidation, summary,
} = S;

const WORKLOG = path.join(__dirname, '..', 'data', 'worklog');
const WORKLOG_DIR = WORKLOG; // 供 server 静态服务附件用
const LOGS_DIR = path.join(WORKLOG, 'logs');
const TASK_FILE = path.join(WORKLOG, 'task-pool.json');

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

/** 任务池 _id 全量集合。task-pool 是单文件、恒为全量，不存在跨月分区导致「任务在别的文件里看不见」，
 *  所以不需要缓存（进程一次也只写一条）。文件不存在 → 返回 null，校验器据此跳过引用检查（无从判断）。 */
function loadTaskIds() {
  if (!fs.existsSync(TASK_FILE)) return null;
  return new Set(loadJson(TASK_FILE, []).map(t => t['_id']).filter(Boolean));
}

function appendLog(rec) {
  // 必填校验：硬不变量，与 warn/strict 无关，任何模式下都阻断
  const miss = requiredMessage('log', rec);
  if (miss) throw new Error(miss);
  // 日期格式校验
  if (!/^\d{4}-\d{2}-\d{2}$/.test(rec['记录日期'])) throw new Error('记录日期格式应为 YYYY-MM-DD: ' + rec['记录日期']);
  // 补缺省
  for (const k of Object.keys(LOG_DEFAULTS)) if (!(k in rec) || rec[k] === '') rec[k] = LOG_DEFAULTS[k];

  const month = rec['记录日期'].slice(0, 7);
  const file = path.join(LOGS_DIR, month + '.json');
  const arr = loadJson(file, []);
  ensureId(rec, 'L', arr.length);
  // 契约校验。idLevel='error'：本路径上 _id 要么由 ensureId 生成（必合规），要么由调用方显式传入——
  // 后者正是 `L-2026091001` 这类手工编号的来源，必须抓住。
  applyValidation(validateRecord('log', rec, { taskIds: loadTaskIds(), idLevel: 'error' }), resolveMode(), 'log ' + rec['_id']);
  arr.push(rec);
  // 按日期排序（稳定保持同日期插入顺序）
  arr.sort((a, b) => (a['记录日期'] || '').localeCompare(b['记录日期'] || ''));
  saveJson(file, arr);
  return { file, total: arr.length, _id: rec['_id'] };
}

function appendTask(rec) {
  // 必填校验：硬不变量，任何模式下都阻断
  const miss = requiredMessage('task', rec);
  if (miss) throw new Error(miss);
  // 补缺省
  for (const k of Object.keys(TASK_DEFAULTS)) if (!(k in rec) || rec[k] === '') rec[k] = TASK_DEFAULTS[k];

  const arr = loadJson(TASK_FILE, []);
  ensureId(rec, 'T', arr.length);
  applyValidation(validateRecord('task', rec, { idLevel: 'error' }), resolveMode(), 'task ' + rec['_id']);
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

  // 必填存在性：只拦「本次把必填项改空」（patch 键口径），不校验整条 ——
  // 实测 `结果类型` 为空的存量记录有 54 条，整条校验会让它们永远无法编辑。
  const miss = requiredMessage('log', merged, Object.keys(patch));
  if (miss) throw new Error(miss);
  // 契约校验：只校验 patch 触及的键。若校验整条，任何无关编辑都会把该条的历史遗留外值重报一遍，
  // 而编辑者当场修不了（它不在 patch 里）→ 噪声淹没信号。
  // idLevel='warn'：_id 在这里是查找键不是数据，不能因为形态不符就阻断存量记录的编辑。
  applyValidation(validateRecord('log', merged, { onlyKeys: Object.keys(patch), taskIds: loadTaskIds(), idLevel: 'warn' }), resolveMode(), 'update-log ' + merged['_id']);

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
  const miss = requiredMessage('task', merged, Object.keys(patch));
  if (miss) throw new Error(miss);
  applyValidation(validateRecord('task', merged, { onlyKeys: Object.keys(patch), idLevel: 'warn' }), resolveMode(), 'update-task ' + merged['_id']);
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
      // 只做 _id 形态提示（onlyKeys 为空 → 不跑枚举/引用校验），且永不阻断：删除是清理动作
      applyValidation(validateRecord('log', arr[i], { onlyKeys: [], idLevel: 'warn' }), resolveMode(), 'delete-log');
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
  applyValidation(validateRecord('task', arr[i], { onlyKeys: [], idLevel: 'warn' }), resolveMode(), 'delete-task');
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

// ---------- 只读辅助：schema 契约 / 按关键词找任务 / 全量契约校验 ----------
function printSchema() {
  const fmt = (list, defs) => list.map(k => {
    const req = LOG_REQUIRED.includes(k) || TASK_REQUIRED.includes(k);
    const d = defs && (k in defs) ? ('  默认: ' + defs[k]) : '';
    return '  ' + k + (req ? ' *必填' : '') + d;
  }).join('\n');
  return [
    '=== worklog schema（真源: tools/worklog-schema.js）===',
    '【日志 log】追加 → logs/YYYY-MM.json',
    fmt(LOG_FIELDS, LOG_DEFAULTS),
    '【任务 task】追加 → task-pool.json（_id 用 update-task 关联/推进）',
    fmt(TASK_FIELDS, TASK_DEFAULTS),
    '【枚举】' + summary(),
    '  所属项目     ' + OPTIONS.projects.join(' / '),
    '  结果类型     ' + OPTIONS.resultTypes.join(' / '),
    '  业务模块     ' + OPTIONS.modules.join(' / '),
    '  项目阶段     ' + OPTIONS.stages.join(' / '),
    '  优先级       ' + OPTIONS.priority.join(' / '),
    '  任务状态     ' + OPTIONS.taskStatus.join(' / '),
    '  问题来源     ' + OPTIONS.sources.join(' / '),
    '  周报归集分类 ' + OPTIONS.weekCat.join(' / '),
    '【无缺省·必须当场判定】结果类型 / 业务模块 / 项目阶段 —— 判不了就问用户，留空优于伪造',
    '【存量枚举外值】见 node agent/mes-report-agent/tools/worklog-append.js validate --detail',
    '_id 自动生成(哈希 L-/T- + 10 位 hex，勿手填)；update-* 为部分字段合并(传什么改什么, 其余保留)；delete 按 _id 精确',
    '=== 结束 ===',
  ].join('\n');
}

/** 全量只读扫描：产出的清单就是第六轮存量治理的工作清单。
 *  输出确定性（排序固定、无时间戳），两次运行逐字节相同 —— 这本身就是一条可断言的性质。 */
const LEVEL_ORDER = ['error', 'warn', 'legacy', 'info'];
function scanWorklog() {
  const taskIds = loadTaskIds();
  const issues = [];
  // 文件过滤必须与 append/update/delete 严格一致（只认 .json）：
  // logs/2026-09.json.bak 若被计入，条数基线直接错。
  const files = fs.existsSync(LOGS_DIR) ? fs.readdirSync(LOGS_DIR).filter(f => f.endsWith('.json')).sort() : [];
  let logCount = 0;
  const logRecs = [];
  for (const f of files) {
    const arr = loadJson(path.join(LOGS_DIR, f), []);
    logCount += arr.length;
    for (const r of arr) {
      logRecs.push({ f, r });
      for (const i of validateRecord('log', r, { taskIds, idLevel: 'error' })) issues.push(Object.assign({ file: f, id: r['_id'] || '(无)' }, i));
      // 必填为空：属存量治理清单，但不是写入时要打断用户的理由（空值不算枚举违规）
      for (const k of missingRequired('log', r)) {
        issues.push({ class: 'required', level: 'legacy', field: k, value: '', file: f, id: r['_id'] || '(无)', msg: '必填字段「' + k + '」为空（历史遗留）' });
      }
    }
  }
  const tasks = loadJson(TASK_FILE, []);
  for (const r of tasks) {
    for (const i of validateRecord('task', r, { idLevel: 'error' })) issues.push(Object.assign({ file: 'task-pool.json', id: r['_id'] || '(无)' }, i));
    for (const k of missingRequired('task', r)) {
      issues.push({ class: 'required', level: 'legacy', field: k, value: '', file: 'task-pool.json', id: r['_id'] || '(无)', msg: '必填字段「' + k + '」为空（历史遗留）' });
    }
  }
  issues.sort((a, b) =>
    a.class.localeCompare(b.class) || a.field.localeCompare(b.field) ||
    LEVEL_ORDER.indexOf(a.level) - LEVEL_ORDER.indexOf(b.level) ||
    a.file.localeCompare(b.file) || String(a.id).localeCompare(String(b.id)) || String(a.value).localeCompare(String(b.value)));
  return { issues, files: files.length, logCount, taskCount: tasks.length };
}

function validateReport(opts) {
  const o = opts || {};
  const s = scanWorklog();
  const byLevel = {}, byClass = {}, byField = {};
  for (const i of s.issues) {
    byLevel[i.level] = (byLevel[i.level] || 0) + 1;
    byClass[i.class] = (byClass[i.class] || 0) + 1;
    byField[i.class + '/' + i.field] = (byField[i.class + '/' + i.field] || 0) + 1;
  }
  if (o.json) {
    return JSON.stringify({
      generatedAt: new Date().toISOString(), writes: 0,
      scanned: { logFiles: s.files, logs: s.logCount, tasks: s.taskCount },
      counts: { level: byLevel, class: byClass, field: byField },
      issues: s.issues,
    }, null, 2);
  }
  const L = [];
  L.push('=== worklog 契约校验报告 ===');
  L.push('值源: tools/worklog-schema.js OPTIONS · 本命令只读，未修改任何文件');
  L.push('扫描: logs/ ' + s.files + ' 个文件 ' + s.logCount + ' 条 · task-pool.json ' + s.taskCount + ' 条');
  L.push('');
  L.push('【汇总】');
  L.push('  ' + LEVEL_ORDER.map(l => l + ' ' + (byLevel[l] || 0)).join(' · '));
  L.push('  按类别: ' + Object.keys(byClass).sort().map(c => c + ' ' + byClass[c]).join(' · '));
  L.push('  legacy = 已知外值（见 worklog-schema.js OUTSIDERS），strict 的切换判据是本桶清零');
  L.push('');
  L.push('【按字段】');
  Object.keys(byField).sort().forEach(k => L.push('  ' + k + '  ' + byField[k] + ' 条'));
  if (o.detail) {
    L.push('');
    L.push('【明细】建议值请从 schema 命令输出的枚举中人工选定，本报告不自动猜测');
    for (const i of s.issues) {
      L.push('  [' + i.class + '|' + i.level + '] ' + i.file + '  ' + i.id + '  ' + i.msg);
    }
  } else {
    L.push('');
    L.push('（加 --detail 看逐条明细；加 --json 供程序消费）');
  }
  return L.join('\n');
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
// 契约类名字为**显式命名 re-export**（不用 ...spread）：spread 会让 schema 将来新增的键
// 静默遮蔽本文件的路径常量。路径常量（LOG_DIR/TASK_FILE/...）只属于本文件，不放进 schema。
module.exports = {
  appendLog, appendTask, updateLog, updateTask, deleteLog, deleteTask, findLog, findTask,
  searchTasks, printSchema, validateReport, scanWorklog, loadJson, saveJson, loadTaskIds,
  // re-export 自 worklog-schema.js（历史调用方沿用的旧名字，勿删）
  makeId, OPTIONS, OUTSIDERS, LOG_DEFAULTS, TASK_DEFAULTS, LOG_FIELDS, LOG_REQUIRED, TASK_FIELDS, TASK_REQUIRED,
  validateRecord, requiredMessage, resolveMode, applyValidation,
  // 本文件的路径与日期常量
  LOGS_DIR, TASK_FILE, WORKLOG_DIR, TODAY,
};

// ---------- CLI 入口 ----------
if (require.main === module) {
  const mode = process.argv[2];
  const jsonArg = process.argv[3];
  // --strict 覆盖环境变量（一次性试跑用）；resolveMode 读的就是这个变量
  if (process.argv.includes('--strict')) process.env.WORKLOG_ENUM_MODE = 'strict';

  // 只读辅助：schema（字段契约）/ validate（全量契约校验）/ search-task（按关键词找关联任务）
  if (mode === 'schema') { console.log(printSchema()); process.exit(0); }
  if (mode === 'validate') {
    console.log(validateReport({ detail: process.argv.includes('--detail'), json: process.argv.includes('--json') }));
    process.exit(0);
  }
  if (mode === 'search-task') {
    if (!jsonArg) { console.error('用法: node worklog-append.js search-task \'<关键词>\''); process.exit(1); }
    const r = searchTasks(jsonArg);
    console.log('命中 ' + r.total + ' 条任务' + (r.total > r.shown ? '（仅显示前 ' + r.shown + '）' : '') + "，关键词: '" + r.query + "'");
    r.lines.forEach(l => console.log('  ' + l));
    process.exit(0);
  }

  if (!mode || !jsonArg) {
    console.error('用法: node worklog-append.js log|task|update-log|update-task|delete-log|delete-task \'<json>\'');
    console.error('  或: node worklog-append.js schema | validate [--detail|--json] | search-task \'<关键词>\'');
    console.error('  加 --strict 可在本次调用中把契约校验切为阻断模式（覆盖 WORKLOG_ENUM_MODE）');
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
