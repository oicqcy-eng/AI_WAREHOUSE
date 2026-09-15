#!/usr/bin/env node
'use strict';
/**
 * search-knowledge.js — Structured Retrieval for MES Knowledge Base
 *
 * 用法:
 *   node tools/search-knowledge.js '<关键词>'                          # 关键词搜索
 *   node tools/search-knowledge.js --domain=<domain> '<关键词>'         # 按领域+关键词
 *   node tools/search-knowledge.js --project=<proj> --domain=<dom>      # 按项目+领域
 *   node tools/search-knowledge.js --list-domains                      # 列出所有领域标签
 *   node tools/search-knowledge.js --json                              # JSON 输出
 *
 * 数据源: knowledge-index.json（静态索引，由 archive-learning 维护）
 * 注意: 此文件已被纳入 git 追踪，更新索引后需 git add + commit
 */

const fs = require('fs');
const path = require('path');

const REPO_ROOT = path.resolve(__dirname, '../../..');
const INDEX_PATH = path.join(REPO_ROOT, 'knowledge-index.json');

function loadIndex() {
  return JSON.parse(fs.readFileSync(INDEX_PATH, 'utf8'));
}

function search(query, options = {}) {
  const { project, domain, type, json = false } = options;
  const index = loadIndex();
  let results = index.entries;

  // 过滤：project
  if (project) {
    results = results.filter(e =>
      e.project.toLowerCase().includes(project.toLowerCase()) ||
      (e.厂区 && e.厂区.toLowerCase().includes(project.toLowerCase()))
    );
  }

  // 过滤：domain
  if (domain) {
    results = results.filter(e => e.domain.includes(domain));
  }

  // 过滤：type
  if (type) {
    results = results.filter(e => e.type === type);
  }

  // 关键词搜索（AND 逻辑：拆分空格，所有 term 都需命中）
  if (query) {
    const terms = query.toLowerCase().split(/\s+/).filter(Boolean);
    results = results.filter(e => {
      const text = (e.title + ' ' + e.keywords.join(' ') + ' ' + e.path).toLowerCase();
      // AND 逻辑：每个 term 都必须匹配（多词精确筛选）
      return terms.every(t => text.includes(t));
    });
  }

  // 去重（按 id）
  const seen = new Set();
  results = results.filter(e => {
    if (seen.has(e.id)) return false;
    seen.add(e.id);
    return true;
  });

  return { index, results };
}

function listDomains() {
  const index = loadIndex();
  const domains = new Set();
  for (const e of index.entries) {
    for (const d of e.domain) domains.add(d);
  }
  return Array.from(domains).sort();
}

// CLI
if (require.main === module) {
  const args = process.argv.slice(2);
  let query = '';
  const options = { json: false };

  for (const arg of args) {
    if (arg.startsWith('--project=')) {
      options.project = arg.slice('--project='.length);
    } else if (arg.startsWith('--domain=')) {
      options.domain = arg.slice('--domain='.length);
    } else if (arg.startsWith('--type=')) {
      options.type = arg.slice('--type='.length);
    } else if (arg === '--json') {
      options.json = true;
    } else if (arg === '--list-domains') {
      const domains = listDomains();
      console.log('可用 domain 标签:');
      for (const d of domains) {
        const count = loadIndex().entries.filter(e => e.domain.includes(d)).length;
        console.log(`  ${d} (${count} 条)`);
      }
      process.exit(0);
    } else if (!arg.startsWith('--')) {
      query = arg;
    }
  }

  const { results } = search(query, options);

  if (options.json) {
    console.log(JSON.stringify({
      version: '1.0.0',
      query,
      options,
      count: results.length,
      results: results.map(r => ({
        id: r.id,
        project: r.project,
        厂区: r.厂区,
        type: r.type,
        title: r.title,
        domain: r.domain,
        keywords: r.keywords,
        path: r.path,
        status: r.status,
      })),
    }, null, 2));
  } else {
    if (!query && !options.domain && !options.project) {
      console.log('用法:');
      console.log('  node tools/search-knowledge.js "<关键词>"');
      console.log('  node tools/search-knowledge.js --domain=barcode "<关键词>"');
      console.log('  node tools/search-knowledge.js --project=hw-spring-mes --domain=equipment');
      console.log('  node tools/search-knowledge.js --list-domains');
      process.exit(0);
    }

    console.log(`搜索: "${query}"${options.domain ? ' domain=' + options.domain : ''}${options.project ? ' project=' + options.project : ''}`);
    console.log(`命中 ${results.length} 条\n`);

    for (const r of results) {
      const domainTag = r.domain.length > 0 ? ` [${r.domain.join(', ')}]` : '';
      const projTag = r.project !== 'shared' ? ` 📁 ${r.project}${r.厂区 ? '/' + r.厂区 : ''}` : '';
      console.log(`  ${r.id}${domainTag}${projTag}`);
      console.log(`  ${r.title}`);
      console.log(`  → ${r.path}`);
      if (r.keywords.length > 0) {
        console.log(`  关键词: ${r.keywords.join(', ')}`);
      }
      console.log();
    }
  }
}

module.exports = { search, listDomains, loadIndex };
