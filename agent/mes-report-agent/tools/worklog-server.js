#!/usr/bin/env node
/** worklog-server.js — 本地工作日志录入服务（替代飞书多维表格的"打开直接录入"）
 *
 * 双击 start-worklog.bat 启动 → 浏览器自动打开录入页 → 下拉选择/填写 → 保存直接写入 worklog/
 *
 * API:
 *   GET  /                    录入页 HTML
 *   GET  /api/options         选项枚举（项目/结果类型/业务模块/阶段/优先级/状态/来源/周报分类）
 *   GET  /api/logs/recent?n=  最近 n 条日志（跨月，日期倒序）
 *   GET  /api/logs/search?q=&n=  按关键字搜索日志（匹配 工作内容/所属项目/业务模块/结果类型/责任人/协作人/交付产出）
 *   GET  /api/logs/today      今日日志（含 是否形成任务=是 计数）
 *   POST /api/logs            追加日志 {record:{...}} → 返回 {total, file, _id}
 *   POST /api/tasks           追加任务 {record:{...}} → 返回 {total, file, _id}
 *   POST /api/logs/update     更新日志 {_id, record:{完整记录}} → 返回 {moved, file, total}
 *   POST /api/tasks/update    更新任务 {_id, record:{完整记录}} → 返回 {file, total}
 *   POST /api/logs/delete     删除日志 {_id} → 返回 {deleted, file, total}
 *   POST /api/tasks/delete    删除任务 {_id} → 返回 {deleted, file, total}
 *   GET  /api/logs/get?id=    按 id 取单条日志（编辑回填）
 *   GET  /api/tasks/get?id=   按 id 取单条任务（编辑回填）
 *   GET  /attachments/<文件名> 附件静态服务（打开/下载 worklog/attachments 下文件）
 *   GET  /api/tasks/recent?n= 最近 n 条任务
 *   GET  /api/tasks/search?q=&n=  按关键字搜索任务（匹配 归集标题/对应项目/问题来源/任务状态/协调资源需求/卡点&问题描述/闭环判定标准/周报归集分类）
 */
'use strict';
const http = require('http');
const fs = require('fs');
const path = require('path');
const { execFile } = require('child_process');
const { appendLog, appendTask, updateLog, updateTask, deleteLog, deleteTask, findLog, findTask, loadJson, LOGS_DIR, TASK_FILE, WORKLOG_DIR, TODAY } = require('./worklog-append.js');
const ATTACH_DIR = path.join(WORKLOG_DIR, 'attachments');

const PORT = process.env.WORKLOG_PORT || 8787;
const UI_FILE = path.join(__dirname, 'worklog-ui.html');

// ===== 选项枚举（与 report-bitable-spec.md §1/§2 一致） =====
const OPTIONS = {
  projects: ['三厂小簧sMES', '一厂大簧sMES', '二厂大簧sMES', '重庆sMES项目', '实验室Lims项目', '无锡泽根sMES项目', '华纬其它项目'],
  resultTypes: ['问题关闭', '方案确认', '配置完成', '培训完成', '数据完成', '上线验证', '风险暴露', '需求确认'],
  modules: ['生产报工', '工单管理', '物料管控', '质量模块', '设备维保', '模治具管理', '安灯异常', '设备数采', '系统接口', '报表看板', '系统管理'],
  stages: ['需求调研', '方案设计', '基础资料收集', '培训上线', '现场实施', '运维优化'],
  priority: ['P1', 'P2', 'P3', 'P4'],
  taskStatus: ['待启动', '进行中', '暂缓', '已闭环'],
  sources: ['现场反馈', '系统异常', '用户需求', '会议决策', '领导要求', '审厂要求'],
  weekCat: ['本周完成', '本周推进', '重点问题', '下周计划', '长期跟踪'],
};

// ===== 读取全量日志（跨月） =====
function allLogs() {
  const arr = [];
  if (fs.existsSync(LOGS_DIR)) {
    for (const f of fs.readdirSync(LOGS_DIR)) {
      if (!f.endsWith('.json')) continue;
      arr.push(...loadJson(path.join(LOGS_DIR, f), []));
    }
  }
  return arr;
}

// 保存后自动重新生成项目驾驶舱（静态快照 → 保持与 worklog 数据同步）
function regenerateDashboard() {
  const gen = path.join(__dirname, 'generate-dashboard.js');
  execFile(process.execPath, [gen], (err, stdout, stderr) => {
    if (err) console.error('[dashboard] 自动刷新失败:', err.message, (stderr || '').trim());
    else {
      const line = (stdout || '').trim().split('\n')[0];
      console.log('[dashboard] 保存后已自动刷新:' + (line ? ' ' + line : ''));
    }
  });
}
function send(res, code, obj) {
  const body = JSON.stringify(obj);
  res.writeHead(code, { 'Content-Type': 'application/json; charset=utf-8', 'Content-Length': Buffer.byteLength(body) });
  res.end(body);
}
function readBody(req) {
  return new Promise((resolve, reject) => {
    let d = '';
    req.on('data', (c) => d += c);
    req.on('end', () => { try { resolve(JSON.parse(d)); } catch (e) { reject(new Error('JSON 解析失败')); } });
    req.on('error', reject);
  });
}

const server = http.createServer(async (req, res) => {
  const url = new URL(req.url, 'http://localhost');
  const p = url.pathname;
  try {
    // 录入页
    if (p === '/' && req.method === 'GET') {
      const html = fs.readFileSync(UI_FILE, 'utf8');
      res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
      res.end(html);
      return;
    }
    // 附件静态服务（worklog/attachments/<文件名>）
    if (p.startsWith('/attachments/') && req.method === 'GET') {
      const name = decodeURIComponent(path.basename(p)); // 只允许文件名，防路径穿越
      const f = path.join(ATTACH_DIR, name);
      if (!fs.existsSync(f) || !fs.statSync(f).isFile()) { send(res, 404, { code: 404, msg: '附件不存在: ' + name }); return; }
      const ext = path.extname(name).toLowerCase();
      const mime = { '.docx': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', '.doc': 'application/msword', '.md': 'text/markdown; charset=utf-8', '.txt': 'text/plain; charset=utf-8', '.xlsx': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', '.pdf': 'application/pdf', '.png': 'image/png', '.jpg': 'image/jpeg', '.jpeg': 'image/jpeg' }[ext] || 'application/octet-stream';
      res.writeHead(200, { 'Content-Type': mime, 'Content-Disposition': "attachment; filename*=UTF-8''" + encodeURIComponent(name) });
      fs.createReadStream(f).pipe(res);
      return;
    }
    // 选项
    if (p === '/api/options' && req.method === 'GET') {
      send(res, 200, { code: 0, data: OPTIONS, today: TODAY });
      return;
    }
    // 最近日志
    if (p === '/api/logs/recent' && req.method === 'GET') {
      const n = Number(url.searchParams.get('n') || 10);
      const logs = allLogs().sort((a, b) => (b['记录日期'] || '').localeCompare(a['记录日期'] || '')).slice(0, n);
      send(res, 200, { code: 0, data: logs });
      return;
    }
    // 搜索日志（按关键字，跨月匹配文本字段；q 为空返回空）
    if (p === '/api/logs/search' && req.method === 'GET') {
      const q = (url.searchParams.get('q') || '').trim();
      const n = Number(url.searchParams.get('n') || 50);
      if (!q) { send(res, 200, { code: 0, data: [], total: 0 }); return; }
      const kw = q.toLowerCase();
      const FIELDS = ['工作内容', '所属项目', '业务模块', '结果类型', '责任人', '协作人', '交付产出'];
      const matched = allLogs().filter(l => FIELDS.some(f => String(l[f] || '').toLowerCase().includes(kw)))
        .sort((a, b) => (b['记录日期'] || '').localeCompare(a['记录日期'] || ''));
      send(res, 200, { code: 0, data: matched.slice(0, n), total: matched.length });
      return;
    }
    // 今日日志 + 统计
    if (p === '/api/logs/today' && req.method === 'GET') {
      const todayLogs = allLogs().filter(l => (l['记录日期'] || '') === TODAY).sort((a, b) => (a['工作内容'] || '').localeCompare(b['工作内容'] || ''));
      send(res, 200, { code: 0, data: { date: TODAY, count: todayLogs.length, formTask: todayLogs.filter(l => l['是否形成任务'] === '是').length, items: todayLogs } });
      return;
    }
    // 追加日志
    if (p === '/api/logs' && req.method === 'POST') {
      const body = await readBody(req);
      const rec = appendLog(body.record || {});
      regenerateDashboard();
      send(res, 200, { code: 0, data: rec });
      return;
    }
    // 追加任务
    if (p === '/api/tasks' && req.method === 'POST') {
      const body = await readBody(req);
      const rec = appendTask(body.record || {});
      regenerateDashboard();
      send(res, 200, { code: 0, data: rec });
      return;
    }
    // 更新日志（按 _id 覆盖；支持跨月移动）
    if (p === '/api/logs/update' && req.method === 'POST') {
      const body = await readBody(req);
      if (!body._id) { send(res, 400, { code: 400, msg: '缺少 _id' }); return; }
      const rec = updateLog(body._id, body.record || {});
      regenerateDashboard();
      send(res, 200, { code: 0, data: rec });
      return;
    }
    // 更新任务（按 _id 覆盖）
    if (p === '/api/tasks/update' && req.method === 'POST') {
      const body = await readBody(req);
      if (!body._id) { send(res, 400, { code: 400, msg: '缺少 _id' }); return; }
      const rec = updateTask(body._id, body.record || {});
      regenerateDashboard();
      send(res, 200, { code: 0, data: rec });
      return;
    }
    // 删除日志（按 _id，跨月文件扫描）
    if (p === '/api/logs/delete' && req.method === 'POST') {
      const body = await readBody(req);
      if (!body._id) { send(res, 400, { code: 400, msg: '缺少 _id' }); return; }
      const rec = deleteLog(body._id);
      regenerateDashboard();
      send(res, 200, { code: 0, data: rec });
      return;
    }
    // 删除任务（按 _id）
    if (p === '/api/tasks/delete' && req.method === 'POST') {
      const body = await readBody(req);
      if (!body._id) { send(res, 400, { code: 400, msg: '缺少 _id' }); return; }
      const rec = deleteTask(body._id);
      regenerateDashboard();
      send(res, 200, { code: 0, data: rec });
      return;
    }
    // 按 id 取单条日志
    if (p === '/api/logs/get' && req.method === 'GET') {
      const id = url.searchParams.get('id');
      const found = findLog(id);
      if (!found) { send(res, 404, { code: 404, msg: '未找到日志 ' + id }); return; }
      send(res, 200, { code: 0, data: found.rec });
      return;
    }
    // 按 id 取单条任务
    if (p === '/api/tasks/get' && req.method === 'GET') {
      const id = url.searchParams.get('id');
      const found = findTask(id);
      if (!found) { send(res, 404, { code: 404, msg: '未找到任务 ' + id }); return; }
      send(res, 200, { code: 0, data: found.rec });
      return;
    }
    // 最近任务
    if (p === '/api/tasks/recent' && req.method === 'GET') {
      const n = Number(url.searchParams.get('n') || 10);
      const tasks = loadJson(TASK_FILE, []).sort((a, b) => (b['发现日期'] || '').localeCompare(a['发现日期'] || '')).slice(0, n);
      send(res, 200, { code: 0, data: tasks });
      return;
    }
    // 搜索任务（按关键字匹配文本字段；q 为空返回空）
    if (p === '/api/tasks/search' && req.method === 'GET') {
      const q = (url.searchParams.get('q') || '').trim();
      const n = Number(url.searchParams.get('n') || 50);
      if (!q) { send(res, 200, { code: 0, data: [], total: 0 }); return; }
      const kw = q.toLowerCase();
      const FIELDS = ['归集标题', '对应项目', '问题来源', '任务状态', '协调资源需求', '卡点&问题描述', '闭环判定标准', '周报归集分类'];
      const matched = loadJson(TASK_FILE, []).filter(t => FIELDS.some(f => String(t[f] || '').toLowerCase().includes(kw)))
        .sort((a, b) => (b['发现日期'] || '').localeCompare(a['发现日期'] || ''));
      send(res, 200, { code: 0, data: matched.slice(0, n), total: matched.length });
      return;
    }
    send(res, 404, { code: 404, msg: 'Not Found: ' + p });
  } catch (e) {
    send(res, 500, { code: 500, msg: e.message });
  }
});

server.listen(PORT, () => {
  console.log('✅ 工作日志录入服务已启动');
  console.log('   打开浏览器: http://localhost:' + PORT);
  console.log('   数据源: agent/mes-report-agent/data/worklog/');
  console.log('   （关闭本窗口即停止服务）');
  // 自动打开浏览器（Windows）
  const { execSync } = require('child_process');
  try { execSync('start "" http://localhost:' + PORT, { shell: 'cmd.exe' }); } catch (e) { /* 忽略 */ }
});
