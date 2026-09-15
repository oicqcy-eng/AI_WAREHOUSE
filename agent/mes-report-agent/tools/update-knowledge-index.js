#!/usr/bin/env node
/**
 * update-knowledge-index.js — 重新生成 knowledge-index.json
 * 
 * 用法:
 *   node tools/update-knowledge-index.js           # 全量重建
 *   node tools/update-knowledge-index.js --watch   # 监听模式（可选）
 */

'use strict';

const fs = require('fs');
const path = require('path');

// Determine REPO_ROOT by finding the project root directory
// The script is at: .../agent/mes-report-agent/tools/update-knowledge-index.js
// REPO_ROOT should be the parent of .../agent/
const SCRIPT_DIR = path.dirname(path.resolve(__filename));
const REPO_ROOT = path.resolve(SCRIPT_DIR, '..', '..');

// Fallback if REPO_ROOT detection fails (Windows path issues)
const FALLBACK_REPO_ROOT = 'D:\AI_WAREHOUSE';
const FINAL_REPO_ROOT = fs.existsSync(path.join(REPO_ROOT, 'CLAUDE.md')) ? REPO_ROOT : FALLBACK_REPO_ROOT;

const INDEX_PATH = path.join(FINAL_REPO_ROOT, 'knowledge-index.json');

// 扫描目录配置 - 所有知识卡片文件的位置
const SCAN_DIRS = [
  'delivery/projects/hw-spring-mes/input/san-chang-xiao-huang/knowledge',
  'agent/mes-implement-expert/data/smes-621/knowledge',
  'agent/mes-implement-expert/data/smes-621-sql/knowledge',
  'agent/mes-implement-expert/data/u9-sql/knowledge',
  'agent/mes-implement-expert/data/lims/knowledge',
];

// 领域分类规则（基于文件路径）
const DOMAIN_RULES = [
  { pattern: /san-chang-xiao-huang/, domain: 'smes-three-factory' },
  { pattern: /smes-621/, domain: 'smes-core' },
  { pattern: /smes-621-sql/, domain: 'smes-sql' },
  { pattern: /u9-sql/, domain: 'u9-erp' },
  { pattern: /lims/, domain: 'lims' },
];

function getProjectFromPath(filePath) {
  if (filePath.includes('san-chang-xiao-huang')) return 'hw-spring-mes';
  if (filePath.includes('smes-621') || filePath.includes('smes-621-sql')) return 'smes-621';
  if (filePath.includes('u9-sql')) return 'u9-sql';
  if (filePath.includes('lims')) return 'lims';
  return 'unknown';
}

function getDomainFromPath(filePath) {
  for (const rule of DOMAIN_RULES) {
    if (rule.pattern.test(filePath)) return rule.domain;
  }
  return 'general';
}

function extractKnowledgeFromFile(filePath) {
  try {
    const content = fs.readFileSync(filePath, 'utf8');
    
    // 解析知识卡片（格式：## K-001: 标题）
    const cards = [];
    const lines = content.split('\n');
    let currentCard = null;
    
    for (let i = 0; i < lines.length; i++) {
      const line = lines[i].trim();
      // 匹配知识卡片标题：## K-xxx: 标题
      const match = line.match(/^##\s+(K-\d+):\s*(.+)$/);
      if (match) {
        if (currentCard) {
          cards.push(currentCard);
        }
        currentCard = {
          id: match[1],
          title: match[2].trim(),
          path: '',
          domain: [],
          keywords: [],
          status: 'active',
          project: ''
        };
      }
    }
    if (currentCard) {
      cards.push(currentCard);
    }
    
    return cards;
  } catch (err) {
    console.error(`读取文件失败: ${filePath}`, err.message);
    return [];
  }
}

function scanKnowledgeFiles() {
  const allEntries = [];
  
  for (const dir of SCAN_DIRS) {
    const fullDir = path.join(FINAL_REPO_ROOT, dir);
    if (!fs.existsSync(fullDir)) continue;
    
    const files = fs.readdirSync(fullDir);
    for (const file of files) {
      if (file === 'knowledge_cards.md' || file === 'knowledge_cards.v2.md') {
        const filePath = path.join(fullDir, file);
        const relativePath = path.relative(FINAL_REPO_ROOT, filePath);
        const cards = extractKnowledgeFromFile(filePath);
        
        for (const card of cards) {
          card.path = relativePath;
          card.project = getProjectFromPath(relativePath);
          card.domain = [getDomainFromPath(relativePath)];
          // 生成关键词（从标题提取）
          card.keywords = card.title.split(/[\s\-_]+/).filter(w => w.length > 1).slice(0, 5);
          card.status = 'active';
          allEntries.push(card);
        }
      }
    }
  }
  
  return allEntries;
}

function generateIndex() {
  console.log('扫描知识文件...');
  console.log('FINAL_REPO_ROOT:', FINAL_REPO_ROOT);
  const entries = scanKnowledgeFiles();
  
  const domainTaxonomy = {};
  for (const entry of entries) {
    for (const d of entry.domain) {
      domainTaxonomy[d] = (domainTaxonomy[d] || 0) + 1;
    }
  }
  
  // 计算覆盖统计
  const total = entries.length;
  const retrievable = entries.filter(e => e.status === 'active').length;
  
  const index = {
    version: '2.0.0',
    schemaVersion: 'structured-retrieval-2.0.0',
    generatedAt: new Date().toISOString().split('T')[0],
    domainTaxonomy,
    coverage: {
      target: '80%',
      current: `${retrievable}/${total}`,
      note: '仅统计可检索知识资产，排除 raw/、inbox/、临时文件'
    },
    entries
  };
  
  fs.writeFileSync(INDEX_PATH, JSON.stringify(index, null, 2), 'utf8');
  console.log(`✅ knowledge-index.json 已更新：${entries.length} 条目，覆盖 ${retrievable}/${total}`);
  return index;
}

// 运行
if (require.main === module) {
  generateIndex();
}

module.exports = { generateIndex, scanKnowledgeFiles };
