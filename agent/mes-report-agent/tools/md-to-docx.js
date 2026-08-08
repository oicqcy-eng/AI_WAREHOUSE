#!/usr/bin/env node
/** md-to-docx.js — 将 reports/ 下汇报 md 转成 WPS 友好的 .docx（清爽彩色风：蓝色表头/状态色点/彩色标题） */
'use strict';
const fs = require('fs');
const path = require('path');
const { Document, Packer, Paragraph, TextRun, Table, TableRow, TableCell,
        WidthType, AlignmentType, BorderStyle, ShadingType, VerticalAlign } = require('docx');

// 汇报目录（可通过命令行第2参数覆盖，默认华纬项目汇报归档目录）
const DEFAULT_REPORTS_DIR = 'd:/AI_WAREHOUSE/delivery/projects/hw-spring-mes/output/reports';
const REPORTS_DIR = process.argv[2] || DEFAULT_REPORTS_DIR;

// 字体配置：微软雅黑（清晰专业、WPS/Office 默认、显示稳定）
const FONT = '微软雅黑';
const SZ = {
  title: 30,      // 大标题（保持）
  h1: 24,         // 一级标题（保持）
  h2: 22,         // 二级标题（保持）
  body: 18,       // 正文 9pt
  quote: 17,      // 引用 8.5pt
  listBullet: 15, // 列表圆点
  cell: 16,       // 表格 8pt（微软雅黑 8pt 是正式汇报稳妥组合）
};

// 配色方案（清爽彩色）
const C = {
  title: '1F4E79',        // 深蓝大标题
  heading: '2E75B6',      // 中蓝小标题
  headerBg: '2E75B6',     // 表头背景蓝
  headerText: 'FFFFFF',   // 表头白字
  zebra: 'F2F7FC',        // 斑马纹浅蓝
  border: 'B4C6E7',       // 浅蓝边框
  red: 'C00000', green: '2E7D32', yellow: 'B26B00', gray: '595959',
  body: '333333',
};

// 状态→颜色（简报/周报的"状态"列）
const STATUS_COLOR = {
  '推进快': C.green, '🟢': C.green, '推进正常': C.green, '按计划': C.green, '收尾': C.green, '稳定': C.green,
  '稳步推进': C.yellow, '多线并行': C.yellow, '进行中': C.yellow, '🟡': C.yellow, '中': C.yellow,
  '卡住': C.red, '阻塞': C.red, '暂缓': C.red, '🔴': C.red, '待启动': C.gray, '未设': C.gray,
};

// 简单 md 解析
function parseMd(md) {
  const lines = md.split('\n');
  const blocks = [];
  let i = 0;
  while (i < lines.length) {
    const line = lines[i];
    const t = line.trim();
    if (!t) { i++; continue; }
    const h = t.match(/^(#{1,6})\s+(.*)$/);
    if (h) { blocks.push({ type: 'heading', level: h[1].length, text: h[2] }); i++; continue; }
    if (t.startsWith('|') && i + 1 < lines.length && /^\s*\|[\s:|-]+\|\s*$/.test(lines[i + 1].trim())) {
      const rows = [];
      while (i < lines.length && lines[i].trim().startsWith('|')) {
        const cells = lines[i].trim().replace(/^\|/, '').replace(/\|$/, '').split('|').map(c => c.trim());
        rows.push(cells);
        i++;
      }
      if (rows.length >= 2 && /^[\s:|-]+$/.test(rows[1].join(''))) rows.splice(1, 1);
      blocks.push({ type: 'table', rows });
      continue;
    }
    if (t.startsWith('>')) { blocks.push({ type: 'quote', text: t.replace(/^>\s?/, '') }); i++; continue; }
    if (/^[-*]\s+/.test(t)) { blocks.push({ type: 'list', text: t.replace(/^[-*]\s+/, '') }); i++; continue; }
    const ol = t.match(/^\d+\.\s+(.*)$/);
    if (ol) { blocks.push({ type: 'olist', text: ol[1] }); i++; continue; }
    blocks.push({ type: 'para', text: t });
    i++;
  }
  return blocks;
}

// 解析 **加粗**，可选整体颜色
function runs(text, baseOpts = {}) {
  const out = [];
  const parts = text.split(/\*\*(.+?)\*\*/g);
  parts.forEach((p, idx) => {
    if (!p) return;
    out.push(new TextRun({ text: p, bold: idx % 2 === 1, ...baseOpts }));
  });
  if (!out.length) out.push(new TextRun({ text, ...baseOpts }));
  return out;
}

// 单元格 → 段落（带颜色/粗体/对齐）
function cellPara(c, opts = {}) {
  const align = opts.align || AlignmentType.CENTER;
  const { color, bold } = opts;
  return new Paragraph({
    children: runs(c, { size: SZ.cell, font: FONT, color, bold }),
    alignment: align,
    spacing: { before: 30, after: 30 },
  });
}

function makeDoc(blocks, title) {
  const children = [];
  // 大标题（深蓝、居中、下划线装饰）
  children.push(new Paragraph({
    children: [new TextRun({ text: title, bold: true, size: SZ.title, font: FONT, color: C.title })],
    alignment: AlignmentType.CENTER,
    spacing: { after: 160 },
  }));
  children.push(new Paragraph({
    children: [new TextRun({ text: '─'.repeat(30), size: 16, color: C.heading })],
    alignment: AlignmentType.CENTER,
    spacing: { after: 120 },
  }));

  for (const b of blocks) {
    switch (b.type) {
      case 'heading': {
        const size = b.level === 1 ? SZ.h1 : b.level === 2 ? SZ.h2 : SZ.h2;
        children.push(new Paragraph({
          children: runs(b.text, { bold: true, size, font: FONT, color: C.heading }),
          spacing: { before: 220, after: 110 },
        }));
        break;
      }
      case 'para': {
        children.push(new Paragraph({
          children: runs(b.text, { size: SZ.body, font: FONT, color: C.body }),
          spacing: { after: 100 },
        }));
        break;
      }
      case 'quote': {
        children.push(new Paragraph({
          children: runs(b.text, { size: SZ.quote, font: FONT, color: '666666' }),
          indent: { left: 360 },
          spacing: { after: 90 },
        }));
        break;
      }
      case 'list': {
        children.push(new Paragraph({
          children: [new TextRun({ text: '● ', size: SZ.listBullet, font: FONT, color: C.heading }), ...runs(b.text, { size: SZ.body, font: FONT, color: C.body })],
          indent: { left: 360 },
          spacing: { after: 80 },
        }));
        break;
      }
      case 'olist': {
        children.push(new Paragraph({
          children: runs(b.text, { size: SZ.body, font: FONT, color: C.body }),
          indent: { left: 360 },
          numbering: { reference: 'list-num', level: 0 },
          spacing: { after: 80 },
        }));
        break;
      }
      case 'table': {
        children.push(buildTable(b.rows));
        children.push(new Paragraph({ children: [new TextRun({ text: '', size: 4 })], spacing: { after: 120 } }));
        break;
      }
    }
  }
  return children;
}

// 每个单元格的统一黑框线（确保 WPS 一定能看到框线）
const CELL_BORDER = { style: BorderStyle.SINGLE, size: 6, color: '333333' };
const CELL_BORDER_HEADER = { style: BorderStyle.SINGLE, size: 8, color: '1F4E79' };

// 按表头名分配列宽比例（长文本列更宽）
function colWidthPcts(header) {
  const WIDE = ['关键看点', '风险', '需协调', '需协调/决策', '闭环判定标准', '问题', '说明', '产出', '工作内容', '卡点', '内容'];
  return header.map(h => {
    const wide = WIDE.find(k => h.includes(k));
    if (wide) return 26;
    if (h.includes('计划闭环') || h.includes('计划完成')) return 13;
    return 10;
  });
}

// 建表格（每个单元格实黑框线 + 智能列宽 + 状态/优先级着色）
function buildTable(rows) {
  const header = rows[0];
  const pcts = colWidthPcts(header);
  const statusIdx = header.findIndex(h => h.includes('状态'));
  const prioIdx = header.findIndex(h => h.includes('优先级'));
  const hasPrioCol = prioIdx >= 0;

  const tableRows = rows.map((cells, ri) => {
    const isHeader = ri === 0;
    const bodyRows = cells.map((c, ci) => {
      let color, bold;
      const align = AlignmentType.LEFT; // 所有单元格文字左对齐（垂直居中）
      if (isHeader) { color = C.headerText; bold = true; }
      else {
        if (ci === statusIdx && STATUS_COLOR[c]) { color = STATUS_COLOR[c]; bold = true; }
        if (hasPrioCol && ci === prioIdx && (c.trim() === 'P1' || c.trim() === 'P2')) { color = c.trim() === 'P1' ? C.red : C.gray; bold = true; }
      }
      const border = isHeader ? CELL_BORDER_HEADER : CELL_BORDER;
      return new TableCell({
        shading: isHeader ? { fill: C.headerBg, type: ShadingType.CLEAR }
                          : (ri % 2 === 0 ? { fill: C.zebra, type: ShadingType.CLEAR } : undefined),
        verticalAlign: VerticalAlign.CENTER,
        width: { size: pcts[ci] || 10, type: WidthType.PERCENTAGE },
        margins: { top: 70, bottom: 70, left: 110, right: 110 },
        borders: {
          top: border, bottom: border, left: border, right: border,
        },
        children: [cellPara(c, { color, bold, align })],
      });
    });
    return new TableRow({ tableHeader: isHeader, children: bodyRows });
  });

  return new Table({
    rows: tableRows,
    width: { size: 100, type: WidthType.PERCENTAGE },
    borders: {
      top: { style: BorderStyle.SINGLE, size: 10, color: '1F4E79' },
      bottom: { style: BorderStyle.SINGLE, size: 10, color: '1F4E79' },
      left: { style: BorderStyle.SINGLE, size: 8, color: '1F4E79' },
      right: { style: BorderStyle.SINGLE, size: 8, color: '1F4E79' },
      insideHorizontal: { style: BorderStyle.SINGLE, size: 6, color: '333333' },
      insideVertical: { style: BorderStyle.SINGLE, size: 6, color: '333333' },
    },
  });
}

(async () => {
  const files = [
    { md: '2026-08-08_周报_W32.md', docx: '2026-08-08_周报_W32.docx', title: '华纬科技 MES 项目周报（2026年第32周，08-03 ~ 08-09）' },
    { md: '2026-08-08_月报_7月.md', docx: '2026-08-08_月报_7月.docx', title: '华纬科技 MES 项目月报（2026年7月复盘）' },
    { md: '2026-08-08_简报.md', docx: '2026-08-08_简报.docx', title: '华纬科技 MES 项目简报（2026-08-08）' },
  ];
  for (const f of files) {
    const mdPath = path.join(REPORTS_DIR, f.md);
    if (!fs.existsSync(mdPath)) { console.log('⚠️ 跳过（不存在）: ' + f.md); continue; }
    const md = fs.readFileSync(mdPath, 'utf8');
    const blocks = parseMd(md);
    if (blocks[0] && blocks[0].type === 'heading' && blocks[0].level === 1) blocks.shift();
    const doc = new Document({
      numbering: { config: [{ reference: 'list-num', levels: [{ level: 0, format: 'decimal', text: '%1.', alignment: AlignmentType.LEFT }] }] },
      sections: [{ children: makeDoc(blocks, f.title), properties: { page: { margin: { top: 1000, bottom: 1000, left: 1100, right: 1100 } } } }],
    });
    const outPath = path.join(REPORTS_DIR, f.docx);
    const buffer = await Packer.toBuffer(doc);
    fs.writeFileSync(outPath, buffer);
    console.log('✅ ' + f.docx + ' (' + (buffer.length / 1024).toFixed(1) + ' KB)');
  }
  console.log('\n全部完成');
})().catch(e => { console.error('❌ ' + e.message); process.exit(1); });
