#!/usr/bin/env node
/** query-mes.js — MES(sMES, SQL Server) 只读查询工具
 *
 * 规则（硬约束，见 tools/README.md）：
 *   - 强制只读：仅允许 SELECT；拒绝 INSERT/UPDATE/DELETE/DROP/ALTER/EXEC 等一切写操作
 *   - 行数封顶（默认显示前 100 行），防大表拉爆内存
 *   - 连接配置走 gitignore 的 db.local.json（不入库）或环境变量 MES_DB_* 覆盖
 *
 * 用法:
 *   node query-mes.js <file.sql>              # 跑一个 SQL 文件（复用 smes-621-sql/ 模板）
 *   node query-mes.js -q "SELECT TOP 10 * FROM tblX"   # 内联 SQL
 *   node query-mes.js <file.sql> --limit 500 -p schema=dbo -p start_date=2026-08-01
 *   node query-mes.js <file.sql> --show 2   # 文件含多个查询时，显示第 2 个结果集
 *   node query-mes.js <file.sql> --out /tmp/result.csv  # 导出 CSV
 *
 * 配置模板见 config/db.local.example.json
 */
'use strict';
const fs = require('fs');
const path = require('path');
// 让 require 能从仓库 tmp/node_modules 解析驱动（无需手动设 NODE_PATH）
module.paths.push(path.join(__dirname, '..', '..', '..', 'tmp', 'node_modules'));
const mssql = require('mssql');

const CONFIG_PATH = path.join(__dirname, '..', 'config', 'db.local.json');

// ---- 读取连接配置：db.local.json 优先，环境变量 MES_DB_* 覆盖 ----
function loadConfig() {
  const base = {};
  if (fs.existsSync(CONFIG_PATH)) {
    try { Object.assign(base, JSON.parse(fs.readFileSync(CONFIG_PATH, 'utf8'))); }
    catch (e) { console.error('❌ 读取 db.local.json 失败: ' + e.message); process.exit(1); }
  }
  const envMap = { server: 'MES_DB_SERVER', port: 'MES_DB_PORT', database: 'MES_DB_DATABASE', user: 'MES_DB_USER', password: 'MES_DB_PASSWORD' };
  for (const k of Object.keys(envMap)) {
    if (process.env[envMap[k]]) base[k] = k === 'port' ? Number(process.env[envMap[k]]) : process.env[envMap[k]];
  }
  if (!base.server || !base.user || !base.password || !base.database) {
    console.error('❌ 缺少连接配置：请填写 ' + CONFIG_PATH);
    console.error('   模板见 config/db.local.example.json；或设环境变量 MES_DB_SERVER / MES_DB_DATABASE / MES_DB_USER / MES_DB_PASSWORD');
    process.exit(1);
  }
  return base;
}

// ---- 只读校验：去注释后首关键字必须 SELECT，且全文禁写关键字 ----
const BANNED = /\b(INSERT|UPDATE|DELETE|DROP|ALTER|CREATE|TRUNCATE|MERGE|GRANT|REVOKE|EXEC|EXECUTE|PROCEDURE|BACKUP|RESTORE|DENY|USE|WAITFOR|OPENROWSET|OPENDATASOURCE)\b/i;
function stripComments(sql) {
  return sql.replace(/\/\*[\s\S]*?\*\//g, ' ').replace(/--[^\r\n]*/g, ' ');
}
function assertReadOnly(sql) {
  const stripped = stripComments(sql).trim();
  if (!stripped) throw new Error('SQL 为空');
  const m = stripped.match(/^([A-Za-z]+)/);
  if (!m) throw new Error('SQL 首关键字无法识别');
  if (!/^select$/i.test(m[1])) throw new Error('仅允许 SELECT（当前首关键字: ' + m[1].toUpperCase() + '）');
  if (BANNED.test(stripped)) throw new Error('检测到禁止的写操作关键字，拒绝执行');
  return stripped;
}

// ---- 占位符替换：{{key}} ← -p key=value ----
function applyParams(sql, params) {
  return sql.replace(/\{\{\s*([A-Za-z_]+)\s*\}\}/g, (m, k) => (k in params ? params[k] : m));
}

async function main() {
  const args = process.argv.slice(2);
  let sqlSource = null, inline = false, limit = 100, out = null, show = 1;
  const params = {};
  for (let i = 0; i < args.length; i++) {
    const a = args[i];
    if (a === '-q') { inline = true; sqlSource = args[++i]; }
    else if (a === '--limit') limit = Number(args[++i]) || 100;
    else if (a === '--out') out = args[++i];
    else if (a === '--show') show = Number(args[++i]) || 1;
    else if (a === '-p') { const kv = args[++i].split('='); params[kv[0]] = kv.slice(1).join('='); }
    else if (a && !a.startsWith('-') && !sqlSource) sqlSource = a;
  }
  if (!sqlSource) { console.error('用法: node query-mes.js <file.sql> | -q "SELECT..." [--limit N] [-p key=value] [--show N] [--out file.csv]'); process.exit(1); }

  let sql;
  if (inline) sql = sqlSource;
  else {
    if (!fs.existsSync(sqlSource)) { console.error('❌ SQL 文件不存在: ' + sqlSource); process.exit(1); }
    sql = fs.readFileSync(sqlSource, 'utf8');
  }
  const finalSql = applyParams(assertReadOnly(sql), params);

  const cfg = loadConfig();
  const pool = await new mssql.ConnectionPool({
    server: cfg.server, port: cfg.port || 1433, database: cfg.database,
    user: cfg.user, password: cfg.password,
    options: Object.assign({ encrypt: false, trustServerCertificate: true }, cfg.options || {}),
    requestTimeout: 60000, connectionTimeout: 15000, pool: { max: 1 }
  }).connect();

  try {
    console.log('▶ 已连接 ' + cfg.server + ':' + (cfg.port || 1433) + '/' + cfg.database + '，执行只读查询…');
    const result = await pool.request().query(finalSql);
    // 支持单/多查询文件：recordsets 全量结果集；--show N 选第 N 个（默认第 1 个）
    const recSets = (result.recordsets && result.recordsets.length) ? result.recordsets : [result.recordset || []];
    if (show < 1 || show > recSets.length) { console.warn('⚠️ --show ' + show + ' 超出范围（该 SQL 含 ' + recSets.length + ' 个查询），改显示第 1 个'); show = 1; }
    if (recSets.length > 1) console.log('ℹ️ 该 SQL 含 ' + recSets.length + ' 个查询，当前显示第 ' + show + ' 个（--show N 切换）');
    const rows = recSets[show - 1] || [];
    const total = rows.length;
    if (total > limit) console.warn('⚠️ 命中 ' + total + ' 行，仅显示前 ' + limit + ' 行（--limit N 可调大）');
    else console.log('✅ 返回 ' + total + ' 行');
    if (out) {
      const headers = Object.keys(rows[0] || {});
      const csv = [headers.join(',')].concat(rows.slice(0, limit).map(r => headers.map(h => '"' + String(r[h] == null ? '' : r[h]).replace(/"/g, '""') + '"').join(','))).join('\n');
      fs.writeFileSync(out, '﻿' + csv, 'utf8');
      console.log('📄 已导出 CSV → ' + out);
    } else {
      console.table(rows.slice(0, limit));
    }
  } finally {
    await pool.close();
  }
}

main().catch(e => { console.error('❌ ' + (e.message || e)); process.exit(1); });
