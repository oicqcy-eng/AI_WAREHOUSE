#!/usr/bin/env node
'use strict';
/**
 * generate-hwit.js — 生成「IT事项」Excel（华纬 IT 服务台格式）
 *
 * 权威规格来源（2026-09-12 从公司原版反解，非自造）：
 *   · 表头/列序 : delivery/inbox/IT事项.xlsx  IT 页（23 列）
 *   · 下拉定义  : 同上 xl/worksheets/sheet1.xml 的 <x:dataValidations>（7 个）
 *   · CAT 选项  : 同上 CAT 页（28 列；本工具修正了原版 W/AA 列损坏的下拉源）
 *   · 优先级矩阵: 同上「优先级矩阵」页（ITIL 影响度 × 紧急度）
 *   · 工作台规则: delivery/inbox/IT管理部工作台配置.xlsx
 *       - 「CAT 是 V1 状态定义的唯一事实来源」
 *       - 「优先级异常：原值无效且无法通过矩阵计算」→ 优先级由工作台按矩阵算，**不手填**
 *       - 「处理人」必须与人员配置姓名一致，否则事项负责人异常
 *       - 关闭状态仅 61-关闭 / 65-关闭-用户撤销
 *
 * 写入方式：SheetJS 生成 + 注入原版 <dataValidations> XML。
 *   为何不用 xlsx-populate：实测它给未指定的选项写 `prompt="undefined"` 等垃圾属性，
 *   Excel 打开会报修复；而 SheetJS 社区版不支持写数据验证。故采用「SheetJS 生成 →
 *   jszip 注入原版 XML」——注入的就是公司自己的那段，兼容性零风险。
 *
 * 数据来源（2026-09-12 起）：`data/worklog/` —— 任务池为主，日志补充。
 *   入选 = ①发现日期在区间内（本期新增）∪ ②实际闭环日期在区间内（本期闭环）
 *          ∪ ③_id 出现在该区间日志的「关联任务」里（本期有实际动作）
 *   映射规则见下方 PROJECT_COMPANY / SOURCE_CATEGORY / STATUS_MAP / *_RULES。
 *   影响度与紧急性 IT 页无源字段，按关键词规则推；未命中落默认值并在报告里列出。
 *
 * 用法:
 *   node tools/generate-hwit.js                                   # 本周，输出 IT事项_<年>W<周>.xlsx
 *   node tools/generate-hwit.js --from=2026-09-07 --to=2026-09-13  # 指定区间
 *   node tools/generate-hwit.js --out=/path/to/x.xlsx              # 指定输出
 */

const fs = require('fs');
const path = require('path');
const XLSX = require('xlsx');
const JSZip = require('jszip');

// ─────────────────────────── IT 页表头（23 列，换行符照抄原版） ───────────────────────────
const IT_HEADERS = ['序号', '分类', '应用分类', '涉及外部客户', '影响度', '紧急性', '优先级',
  '问题/需求描述', '根本原因分析/需求分析', '提出公司/职能中心', '提出部门', '提出人',
  '提出时间\n(YYYY/MM/DD)', '处理人', '处理状态\n(未解决/已解决)', '响应时间\n(YYYY/MM/DD)',
  '计划完成时间\n(YYYY/MM/DD)', '实际完成时间\n(YYYY/MM/DD)', '处理方式/最终结果', '备注',
  '响应持续时间\n(Days)', '计划完成-实际完成\n(Days)', '实际完成持续时间\n(Days)'];

// 列索引常量（易读，防错位）
const C = {
  序号: 0, 分类: 1, 应用分类: 2, 涉及外部客户: 3, 影响度: 4, 紧急性: 5, 优先级: 6,
  描述: 7, 根因: 8, 提出公司: 9, 提出部门: 10, 提出人: 11, 提出时间: 12,
  处理人: 13, 处理状态: 14, 响应时间: 15, 计划完成: 16, 实际完成: 17,
  处理结果: 18, 备注: 19, 响应持续: 20, 计划实际差: 21, 实际持续: 22,
};

// 日期列（写 Excel 序列号 + yyyy/mm/dd 格式，与原版一致）
const DATE_COLS = [C.提出时间, C.响应时间, C.计划完成, C.实际完成];

/** 'YYYY-MM-DD' → Excel 日期序列号（1900 日期系统） */
function serial(ymd) {
  if (!ymd) return '';
  const [y, m, d] = ymd.split('-').map(Number);
  return Math.round((Date.UTC(y, m - 1, d) - Date.UTC(1899, 11, 30)) / 86400000);
}

/** 'YYYY-MM-DD' → 显示用字符串 yyyy-m-d（横杠格式） */
function fmtDate(ymd) {
  if (!ymd) return '';
  return ymd; // 保持原格式 yyyy-mm-dd
}

/** 组装一行（23 列，位置固定，不靠数组长度猜） */
function row(o) {
  const r = new Array(23).fill('');
  r[C.序号] = o.no;
  r[C.分类] = o.cat;
  r[C.应用分类] = o.app;
  r[C.涉及外部客户] = o.customer;
  r[C.影响度] = o.impact;
  r[C.紧急性] = o.urgency;
  r[C.优先级] = '';                      // ★ 恒空：由工作台按 ITIL 矩阵计算
  r[C.描述] = o.desc;
  r[C.根因] = o.cause;
  r[C.提出公司] = o.company;
  // 提出部门：从标题提取（如 质量模块、设备管理），拿不准回退 DEPT
  r[C.提出部门] = o.dept || DEPT;
  r[C.提出人] = o.proposer;
  // 日期列需加 z 格式，否则 Excel 会按系统区域显示（如 2026/9/11）
  const fmt = 'yyyy-m-d';
  r[C.提出时间] = fmtDate(o.raisedAt);
  r[C.响应时间] = fmtDate(o.respondedAt);
  r[C.计划完成] = fmtDate(o.dueAt);
  r[C.实际完成] = fmtDate(o.doneAt);
  r[C.处理结果] = o.result;
  r[C.备注] = o.note;
  // 20/21/22 持续时间三列恒空：由工作台按上列日期计算
  return r;
}

// ─────────────────────────── 配置 ───────────────────────────
const DEPT = 'IT管理部';
const OWNER = '陈宇';   // 须与「IT管理部工作台配置」人员配置姓名一致（060172 陈宇 / Staff / MES）

const WORKLOG_DIR = path.resolve(__dirname, '..', 'data', 'worklog');

// 对应项目 → 提出公司编码（CAT K 列）。
// ev = 依据强度；每次生成都会把非 ✅ 的项连同命中条数打进报告，供人工复核。
const PROJECT_COMPANY = {
  '三厂小簧sMES':     { code: '04-诸暨3厂',  ev: '✅ 有明文依据' },
  '一厂大簧sMES': { code: '02-诸暨1厂',  ev: '✅ 用户 2026-09-12 确认对应关系正确' },
  '二厂大簧sMES': { code: '03-诸暨2厂',  ev: '✅ 用户 2026-09-12 确认对应关系正确' },
  '重庆sMES项目':     { code: '07-重庆工厂', ev: '✅ 厂名直译' },
  '无锡泽根sMES项目': { code: '06-无锡弹簧', ev: '⚠️ 推断：无锡=无锡弹簧' },
  '实验室Lims项目':   { code: '',            ev: '❓ 无依据，留空待指定' },
  '华纬其它项目':     { code: '01-集团',     ev: '⚠️ 归入集团职能中心' },
};

// 对应项目 → 应用分类（CAT G 列）。CAT 无 LIMS 选项，非 sMES 一律留空。
function appOf(project) { return /sMES/.test(project || '') ? '01-MES' : ''; }

// 问题来源 → 分类（CAT C 列）
const SOURCE_CATEGORY = {
  '现场反馈': '02-Incident', '系统异常': '02-Incident',
  '用户需求': '04-Request', '领导要求': '04-Request', '审厂要求': '04-Request',
  '会议决策': '01-Task',
};

// 任务状态 → 处理状态（CAT S 列）。关闭态只有 61/65 被工作台承认。
const STATUS_MAP = { '待启动': '31-评估', '进行中': '41-处理', '暂缓': '71-其他', '已闭环': '61-关闭' };

// 影响度 / 紧急性：IT 页无对应字段，只能从标题+描述按关键词推。
// 命中即用；未命中落默认值，并在报告里逐条列出（这些需要人工过目）。
const IMPACT_RULES = [
  { v: '10-高', re: /停线|停产|全线|全厂|无法使用|不可用|阻塞|阻断|上线前必须|影响结算|数据错误|跨组织/ },
  { v: '20-中', re: /工序|卡控|绕行|批号|上料|校验|接口|同步|导入|部署|请购|审批/ },
  { v: '30-低', re: /查询|优化|整理|归档|文档|手册|培训|点检资料|纪要/ },
];
const URGENCY_RULES = [
  { v: '10-高', re: /逾期|已延期|紧急|加急|停线|阻塞|本周必须|上线前/ },
  { v: '20-中', re: /计划|截止|推进|跟踪/ },
  { v: '30-低', re: /长期|暂缓|待定|观察/ },
];

// ITIL 优先级矩阵（影响度 × 紧急度）——**只用于反查校验，绝不写进表**（G 列恒空）
const P_MATRIX = {
  '10-高|10-高': 'P1', '10-高|20-中': 'P1', '10-高|30-低': 'P2',
  '20-中|10-高': 'P1', '20-中|20-中': 'P2', '20-中|30-低': 'P3',
  '30-低|10-高': 'P2', '30-低|20-中': 'P3', '30-低|30-低': 'P4',
};
const URGENCY_ORDER = ['10-高', '20-中', '30-低'];

/**
 * 任务池优先级 → 影响度/紧急性的「档位锚」。
 * 任务池的 `优先级` 是**你自己下的判断**，比关键词正则可靠，所以拿它当锚：
 * 定出影响度/紧急性后，必须能通过矩阵反查回同一个档位——否则工作台算出的优先级
 * 会与你自己的判断打架（这正是之前 8/17 条不一致的来源）。
 */
const P_TIER = {
  P1: ['10-高', '10-高'], P2: ['20-中', '20-中'],
  P3: ['20-中', '30-低'], P4: ['30-低', '30-低'],
};

function matchRule(rules, text, dflt) {
  for (const r of rules) if (r.re.test(text)) return r.v;
  return dflt;
}

/**
 * 推 影响度 / 紧急性 / 期望优先级。
 * - 任务池有优先级 → **该档必现**：关键词只在档内挑影响度，紧急性由矩阵反查补齐；
 *   关键词与该档冲突（如判「低」却是 P1）→ 回退该档规范代表，并记一条提示。
 * - 任务池无优先级 → 纯关键词；两个都没命中就**留空**，报告里列出让你定（不硬猜）。
 */
function deriveIE(t, blind, notes) {
  const taskP = String(t['优先级'] || '').toUpperCase();
  const kwI = matchRule(IMPACT_RULES, blind, '');
  const kwU = matchRule(URGENCY_RULES, blind, '');
  const id = t['_id'] || t['归集标题'] || '';
  const tier = P_TIER[taskP];

  if (!tier) {                                    // 任务池没写优先级：不硬猜
    if (!kwI && !kwU) {
      notes.push('影响度/紧急性留空（待你指定）｜' + id + '｜任务池无优先级，关键词也没命中');
      return { impact: '', urgency: '', p: '' };
    }
    const impact = kwI || '20-中', urgency = kwU || '20-中';
    return { impact, urgency, p: P_MATRIX[impact + '|' + urgency] || '' };
  }

  let impact = kwI || tier[0];
  let urgency = null;
  const cand = kwU ? [kwU, ...URGENCY_ORDER.filter(u => u !== kwU)] : URGENCY_ORDER;
  urgency = cand.find(u => P_MATRIX[impact + '|' + u] === taskP);
  if (!urgency) {                                 // 关键词影响度与档位不相容 → 回退规范代表
    if (kwI) notes.push('影响度按任务池档位修正｜' + id + '｜关键词判 ' + kwI + '，任务池记 ' + taskP + '，不相容');
    impact = tier[0]; urgency = tier[1];
  } else if (kwU && urgency !== kwU) {
    notes.push('紧急性按任务池档位修正｜' + id + '｜关键词判 ' + kwU + '，任务池记 ' + taskP + '，不相容');
  }
  return { impact, urgency, p: P_MATRIX[impact + '|' + urgency] };
}

/** 从「卡点&问题描述」里抽「反馈人：X」「处理人：Y」这类内嵌字段 */
function extractField(text, label) {
  const m = new RegExp(label + '：([^；;]+)').exec(text || '');
  return m ? m[1].trim() : '';
}

/** 任务池记录 → IT 事项行对象 */
function mapTask(t, issues, notes) {
  const title = (t['归集标题'] || '').replace(/^【/, '').replace(/】$/, '');
  const cause = t['卡点&问题描述'] || '';
  const blind = title + ' ' + cause;              // 关键词匹配用的合并文本
  const project = t['对应项目'] || '';
  const comp = PROJECT_COMPANY[project] || { code: '', ev: '❓ 未登记的对应项目' };

  const { impact, urgency, p } = deriveIE(t, blind, notes);
  const st = t['任务状态'] || '';

  const srcOwner = extractField(cause, '处理人');
  const note = [
    t['进度百分比'] ? '进度 ' + t['进度百分比'] : '',
    t['_id'] || '',
    srcOwner && srcOwner !== OWNER ? '源表处理人：' + srcOwner : '',
  ].filter(Boolean).join('；');

  if (!comp.code) issues.push('提出公司留空｜' + project + '｜' + comp.ev);
  if (!appOf(project)) issues.push('应用分类留空｜' + project + '｜CAT 无对应选项');

  // 从标题提取部门：格式为「厂区-部门-内容」，取第一个 - 后面的部分
  const deptMatch = title.match(/^[^-]+-(.+?)-/);
  const dept = deptMatch ? deptMatch[1].trim() : '';

  const taskP = t['优先级'] || '';

  return {
    no: 0,
    cat: SOURCE_CATEGORY[t['问题来源']] || '02-Incident',
    app: appOf(project),
    customer: 'A01-All',
    impact, urgency,
    desc: title,
    cause: cause || t['闭环判定标准'] || '',
    company: comp.code,
    dept: dept || DEPT,  // 提出部门从标题提取，拿不准回退 DEPT
    proposer: extractField(cause, '反馈人'),
    raisedAt: t['发现日期'] || '',
    owner: OWNER,
    status: STATUS_MAP[st] || '31-评估',
    respondedAt: t['发现日期'] || '',
    dueAt: t['计划完成日期'] || '',
    doneAt: t['实际闭环日期'] || '',
    result: t['闭环判定标准'] || '',
    note,
    _id: t['_id'] || '', _why: '', _p: p, _taskP: taskP, _ev: comp.ev, _src: t['问题来源'] || '',
  };
}

/**
 * 从 worklog 采集本期事项。
 * 入选 = 三条并集，每条都记入选理由（报告里逐条列出）：
 *   ① 发现日期落在 [from, to]        —— 本期新增
 *   ② 实际闭环日期落在 [from, to]    —— 本期闭环
 *   ③ _id 出现在本期日志的「关联任务」—— 本期有实际动作
 */
/**
 * 内部动作过滤器 —— 命中即**不入选**，但会在报告里逐条列出理由（不静默丢弃）。
 * 依据 runbook「陷阱」：归档/提炼/建卡是内部动作，不是日常处理的新增事项；
 * 本工具自身的建设同属此类（它由 IT 事项流程派生，写进 IT 事项表会自我指涉）。
 *
 * ⚠️ **只扫标题，不扫「卡点&问题描述」**：描述里全是业务过程词，
 * 实测「入库」会命中「IQC→派工→制样→报工→PQC→完工→入库」这类正常流程描述，
 * 把真事项误剔（2026-09-12 踩过）。内部动作的**标题本身就是动作**，标题足够。
 */
const EXCLUDE_RULES = [
  { re: /投喂|归档|提炼|沉淀|知识卡/, why: '投喂/归档/提炼/建卡类内部动作（见 runbook 陷阱）' },
  { re: /IT事项工单表|工单表按周生成|HWIT/, why: '本工具自身的建设，非日常处理事项' },
];

function collect(from, to, issues, notes) {
  const parsed = JSON.parse(fs.readFileSync(path.join(WORKLOG_DIR, 'task-pool.json'), 'utf8'));
  const tasks = Array.isArray(parsed) ? parsed : (parsed.tasks || parsed.records || []);

  const linked = new Set();
  const logDir = path.join(WORKLOG_DIR, 'logs');
  for (const f of fs.readdirSync(logDir).filter(x => /^\d{4}-\d{2}\.json$/.test(x))) {
    const lp = JSON.parse(fs.readFileSync(path.join(logDir, f), 'utf8'));
    const arr = Array.isArray(lp) ? lp : (lp.logs || lp.records || []);
    for (const l of arr) {
      const d = l['记录日期'] || '';
      if (!d || d < from || d > to) continue;
      for (const id of String(l['关联任务'] || '').split(/[,，;；\s]+/).filter(Boolean)) linked.add(id);
    }
  }

  const inRange = d => !!d && d >= from && d <= to;
  const picked = [];
  for (const t of tasks) {
    const why = [];
    if (inRange(t['发现日期'])) why.push('本期新增');
    if (inRange(t['实际闭环日期'])) why.push('本期闭环');
    if (linked.has(t['_id'])) why.push('本期日志关联');
    if (!why.length) continue;
    const hit = EXCLUDE_RULES.find(r => r.re.test(t['归集标题'] || ''));
    if (hit) { notes.push('已剔除｜' + (t['归集标题'] || t['_id']) + '｜' + hit.why + '｜入选理由 ' + why.join('+')); continue; }
    picked.push({ t, why: why.join('+') });
  }
  picked.sort((a, b) => String(a.t['发现日期'] || '').localeCompare(String(b.t['发现日期'] || '')));

  const items = picked.map(({ t, why }) => { const o = mapTask(t, issues, notes); o._why = why; return o; });
  items.forEach((o, i) => { o.no = i + 1; });
  return items;
}

/** IT 事项行对象数组 → 工作表二维数组 */
function buildITRows(items) { return [IT_HEADERS, ...items.map(row)]; }

// ─────────────────────────── CAT 页（28 列）───────────────────────────
// 原版 W/AA 列（影响度/紧急度的 _Excel 下拉源）已损坏：内容为 [29, 29, "30-低"]。
// 此处按原版 IT 页样例行实际使用的标签修正为 10-高 / 20-中 / 30-低。
const IMPACT_LABELS = ['10-高', '20-中', '30-低'];
const URGENCY_LABELS = ['10-高', '20-中', '30-低'];

function catRow(i, o) {
  const r = new Array(28).fill(null);
  r[0] = o.no1; r[1] = o.v1; r[2] = o.e1; r[3] = o.c1;
  r[4] = o.no2; r[5] = o.v2; r[6] = o.e2; r[7] = null;
  r[8] = o.no3; r[9] = o.v3; r[10] = o.e3; r[11] = o.c3;
  r[12] = o.no4; r[13] = o.v4; r[14] = o.e4; r[15] = o.c4;
  r[16] = o.no5; r[17] = o.v5; r[18] = o.e5; r[19] = null;
  r[20] = o.no6; r[21] = o.v6; r[22] = o.e6; r[23] = null;
  r[24] = o.no7; r[25] = o.v7; r[26] = o.e7; r[27] = null;
  return r;
}

const CAT_HEADERS = ['No1', 'Category', 'Category_Excel', 'Comment1',
  'No2', 'App', 'App_Excel', 'Comment2',
  'No3', 'Company', 'Company_Excel', 'Comment3',
  'No4', 'Customer', 'Customer_Excel', 'Comment4',
  'No5', 'Status', 'Status_Excel', 'Comment5',
  'No6', '影响度', 'Impact_Excel', 'Comment6',
  'No7', '紧急性', 'Urgency_Excel', 'Comment7'];

// 原版 CAT 各列取值（照抄，不改内容）
const CAT_CATEGORY = [['01', 'Task', '01-Task', '任务（安装软件、布线、调试终端设备等等）'],
  ['02', 'Incident', '02-Incident', '故障（系统问题、应用卡顿等等）'],
  ['03', 'Problem', '03-Problem', '问题（疑难杂症，短期无法处理）'],
  ['04', 'Request', '04-Request', '需求（新增软件功能、新增流程等等）'],
  ['05', 'Project', '05-Project', '项目（需要组建团队解决、或者长期资源解决）']];

const CAT_APP = [['01', 'MES'], ['02', 'U9C'], ['03', 'WMS'], ['04', 'PLM'], ['05', 'Security'],
  ['06', 'Workplace'], ['07', '研发云'], ['08', 'PDA'], ['09', 'Network']];

const CAT_COMPANY = [['01', '集团', '职能中心'], ['02', '诸暨1厂'], ['03', '诸暨2厂'], ['04', '诸暨3厂'],
  ['05', '诸暨金晟'], ['06', '无锡弹簧'], ['07', '重庆工厂'], ['08', '南京工厂'], ['09', '河南工厂'],
  ['10', '德国工厂'], ['11', '墨西哥工厂'], ['12', '摩洛哥工厂'],
  ['A01', 'All', '所有'], ['A02', 'Domestic', '国内所有'], ['A03', 'International', '国际所有'],
  ['A21', 'Zhuji', '诸暨工厂'], ['A22', 'Non-Zhuji', '国内非诸暨工厂'],
  ['G21', 'HRG', '集团HR'], ['G22', 'PRG', '集团采购'], ['G23', 'ITG', '集团IT'],
  ['G24', 'FTG', '集团财务'], ['G25', 'MGG', '集团运营'], ['G26', 'QMG', '集团质量'], ['G27', 'LOG', '集团物流']];

const CAT_CUSTOMER = [['D01', 'Lixiang', '理想'], ['D02', 'Weilai', '蔚来'], ['D03', 'Xiaopeng', '小鹏'],
  ['D04', 'Geely', '吉利'], ['D05', 'GreatWall', '长城'], ['D06', 'FAW', '一汽'],
  ['I01', 'Ford', '福特'], ['I02', 'Stellantis', '斯特兰蒂斯'], ['I03', 'BMW', '宝马'],
  ['I04', 'VW', '大众'], ['I05', 'Volve', '沃尔沃'],
  ['A01', 'All', '所有'], ['A02', 'Domestic', '国内所有'], ['A03', 'International', '国际所有']];

const CAT_STATUS = [['11', '提出-业务澄清'], ['12', '提出-客户澄清'], ['13', '提出-其他澄清'],
  ['14', '提出-技术澄清'], ['21', '接受'], ['31', '评估'], ['41', '处理'], ['51', '验证'],
  ['61', '关闭'], ['65', '关闭-用户撤销'], ['71', '其他']];

const CAT_ROWS = [CAT_HEADERS];
const CAT_LEN = 24;   // 原版 25 行 → 24 条数据行
for (let i = 0; i < CAT_LEN; i++) {
  const cat = CAT_CATEGORY[i] || [];
  const app = CAT_APP[i] || [];
  const com = CAT_COMPANY[i] || [];
  const cus = CAT_CUSTOMER[i] || [];
  const sta = CAT_STATUS[i] || [];
  CAT_ROWS.push(catRow(i, {
    no1: cat[0] || null, v1: cat[1] || null, e1: cat[2] || null, c1: cat[3] || null,
    no2: app[0] || null, v2: app[1] || null, e2: app[1] ? app[0] + '-' + app[1] : null,
    no3: com[0] || null, v3: com[1] || null, e3: com[1] ? com[0] + '-' + com[1] : null, c3: com[2] || null,
    no4: cus[0] || null, v4: cus[1] || null, e4: cus[1] ? cus[0] + '-' + cus[1] : null, c4: cus[2] || null,
    no5: sta[0] || null, v5: sta[1] || null, e5: sta[1] ? sta[0] + '-' + sta[1] : null,
    no6: IMPACT_LABELS[i] ? String((i + 1) * 10) : null,
    v6: IMPACT_LABELS[i] ? IMPACT_LABELS[i].slice(3) : null,
    e6: IMPACT_LABELS[i] || null,
    no7: URGENCY_LABELS[i] ? String((i + 1) * 10) : null,
    v7: URGENCY_LABELS[i] ? URGENCY_LABELS[i].slice(3) : null,
    e7: URGENCY_LABELS[i] || null,
  }));
}

// ─────────────────────────── 数据验证（原样照抄公司原版 sheet1.xml） ───────────────────────────
const DV_RANGES = [
  ['B', "'CAT'!$C$2:$C$6"],    // 分类
  ['C', "'CAT'!$G$2:$G$10"],   // 应用分类
  ['D', "'CAT'!$O$2:$O$15"],   // 涉及外部客户
  ['E', "'CAT'!$W$2:$W$4"],    // 影响度
  ['F', "'CAT'!$AA$2:$AA$4"],  // 紧急性
  ['J', "'CAT'!$K$2:$K$27"],   // 提出公司/职能中心
  ['O', "'CAT'!$S$2:$S$12"],   // 处理状态
];

// ★ 优先级 G 列**不在**此列 —— 原版即无下拉，且工作台按 ITIL 矩阵计算，故留空不设验证。
const DATA_VALIDATIONS =
  '<dataValidations count="' + DV_RANGES.length + '">' +
  DV_RANGES.map(([col, formula]) =>
    '<dataValidation type="list" allowBlank="1" showDropDown="0" sqref="' + col + '2:' + col + '200">' +
    '<formula1>' + formula + '</formula1></dataValidation>').join('') +
  '</dataValidations>';

// ─────────────────────────── 构建 ───────────────────────────
function buildWorkbook(itRows) {
  const wb = XLSX.utils.book_new();

  const wsIT = XLSX.utils.aoa_to_sheet(itRows);
  wsIT['!cols'] = [{ wch: 6 }, { wch: 13 }, { wch: 11 }, { wch: 14 }, { wch: 9 }, { wch: 9 }, { wch: 9 },
    { wch: 42 }, { wch: 60 }, { wch: 16 }, { wch: 14 }, { wch: 10 }, { wch: 14 },
    { wch: 10 }, { wch: 14 }, { wch: 14 }, { wch: 14 }, { wch: 14 }, { wch: 40 }, { wch: 40 },
    { wch: 12 }, { wch: 14 }, { wch: 14 }];
  wsIT['!freeze'] = { xSplit: 0, ySplit: 1 };
  // 日期列套 yyyy/mm/dd（只对有效的数字序列号设置格式）
  for (let r = 2; r <= itRows.length; r++) {
    for (const ci of DATE_COLS) {
      const addr = XLSX.utils.encode_cell({ c: ci, r: r - 1 });
      if (wsIT[addr] && typeof wsIT[addr].v === 'number') wsIT[addr].z = 'yyyy-m-d';
    }
  }
  XLSX.utils.book_append_sheet(wb, wsIT, 'IT');

  const wsCAT = XLSX.utils.aoa_to_sheet(CAT_ROWS);
  wsCAT['!cols'] = [{ wch: 6 }, { wch: 12 }, { wch: 14 }, { wch: 34 },
    { wch: 6 }, { wch: 12 }, { wch: 12 }, { wch: 8 },
    { wch: 6 }, { wch: 12 }, { wch: 12 }, { wch: 10 },
    { wch: 6 }, { wch: 12 }, { wch: 14 }, { wch: 10 },
    { wch: 6 }, { wch: 16 }, { wch: 16 }, { wch: 8 },
    { wch: 6 }, { wch: 9 }, { wch: 11 }, { wch: 8 },
    { wch: 6 }, { wch: 9 }, { wch: 11 }, { wch: 8 }];
  XLSX.utils.book_append_sheet(wb, wsCAT, 'CAT');

  return wb;
}

/** 把 <dataValidations> 注入 IT 页 XML（schema 顺序：sheetData 之后、pageMargins 之前） */
async function inject(xlsxBuf) {
  const zip = await JSZip.loadAsync(xlsxBuf);
  const sheetPath = 'xl/worksheets/sheet1.xml';
  const file = zip.file(sheetPath);
  if (!file) throw new Error('找不到 ' + sheetPath);
  let xml = await file.async('string');
  if (xml.indexOf('<dataValidations') !== -1) {
    throw new Error('该工作簿已含 dataValidations，注入会重复');
  }
  const anchors = ['<pageMargins', '<hyperlinks', '<printOptions', '<headerFooter', '</worksheet>'];
  let at = -1;
  for (const a of anchors) {
    const i = xml.indexOf(a);
    if (i !== -1 && (at === -1 || i < at)) at = i;
  }
  if (at === -1) throw new Error('无法定位注入锚点');
  xml = xml.slice(0, at) + DATA_VALIDATIONS + xml.slice(at);
  zip.file(sheetPath, xml);
  return zip.generateAsync({ type: 'nodebuffer', compression: 'DEFLATE' });
}

// ─────────────────────────── 校验 ───────────────────────────
function verify(outPath) {
  const wb = XLSX.readFile(outPath);
  const ws = wb.Sheets['IT'];
  const rows = XLSX.utils.sheet_to_json(ws, { header: 1, raw: true, defval: null, blankrows: false });
  const problems = [];

  const allowed = {
    1: CAT_CATEGORY.map(r => r[2]),
    2: CAT_APP.map(r => r[0] + '-' + r[1]),
    3: CAT_CUSTOMER.map(r => r[0] + '-' + r[1]),
    4: IMPACT_LABELS,
    5: URGENCY_LABELS,
    9: CAT_COMPANY.filter(Boolean).map(r => r[0] + '-' + r[1]),
    14: CAT_STATUS.map(r => r[0] + '-' + r[1]),
  };
  const names = { 1: '分类', 2: '应用分类', 3: '涉及外部客户', 4: '影响度', 5: '紧急性', 9: '提出公司', 14: '处理状态' };

  let prioFilled = 0, durFilled = 0;
  const blanks = [];
  for (let i = 1; i < rows.length; i++) {
    const r = rows[i];
    for (const ci of Object.keys(allowed).map(Number)) {
      const v = r[ci];
      // 空值 ≠ 越界：拿不准时**有意留空**是设计的一部分（比硬猜一个枚举值更诚实），
      // 单独计数并在报告里列出，交由你填。
      if (v === null || v === undefined || v === '') {
        blanks.push('第' + (i + 1) + '行 ' + names[ci] + ' 留空（待你指定）');
        continue;
      }
      if (!allowed[ci].includes(v)) {
        problems.push('第' + (i + 1) + '行 ' + names[ci] + ' 越界: ' + JSON.stringify(v));
      }
    }
    if (r[6]) prioFilled++;
    for (const ci of [20, 21, 22]) if (r[ci] !== null && r[ci] !== undefined && r[ci] !== '') durFilled++;
    if (!r[13]) problems.push('第' + (i + 1) + '行 处理人为空（工作台将报负责人异常）');
    if (!r[0]) problems.push('第' + (i + 1) + '行 序号为空（工作台关联键无效）');
    if (!r[10]) problems.push('第' + (i + 1) + '行 提出部门为空');
    for (const ci of [7, 8]) if (!r[ci]) problems.push('第' + (i + 1) + '行 ' + (ci === 7 ? '问题/需求描述' : '根本原因分析') + '为空');
  }
  const seq = rows.slice(1).map(r => r[0]);
  if (new Set(seq).size !== seq.length) problems.push('序号有重复');

  console.log('  IT 页: ' + (rows.length - 1) + ' 条事项 × 23 列');
  console.log('  CAT 页: ' + (CAT_ROWS.length - 1) + ' 条选项定义 × 28 列');
  console.log('  优先级列填写数: ' + prioFilled + ' (应为 0) ' + (prioFilled === 0 ? '✅' : '❌'));
  console.log('  U/V/W 时间列填写数: ' + durFilled + ' (应为 0) ' + (durFilled === 0 ? '✅' : '❌'));
  console.log('  枚举越界: ' + problems.length + ' 项 ' + (problems.length === 0 ? '✅' : '❌'));
  problems.forEach(p => console.log('    · ' + p));
  console.log('  有意留空: ' + blanks.length + ' 项（非错误，见报告「待你指定」）');
  return problems.length === 0 && prioFilled === 0 && durFilled === 0;
}

// 输出路径**按仓库根解析**，与当前工作目录无关。
// （曾用相对路径，从 agent/ 目录执行会把产物写进 agent/mes-report-agent/delivery/ 而不报错。）
const REPO_ROOT = path.resolve(__dirname, '..', '..', '..');

const ymd = d => d.getFullYear() + '-' + String(d.getMonth() + 1).padStart(2, '0') + '-' + String(d.getDate()).padStart(2, '0');

/** 本周（周一 ~ 周日，本地时间） */
function thisWeek() {
  const d = new Date();
  const dow = (d.getDay() + 6) % 7;                       // 周一=0
  const mon = new Date(d); mon.setDate(d.getDate() - dow);
  const sun = new Date(mon); sun.setDate(mon.getDate() + 6);
  return { from: ymd(mon), to: ymd(sun) };
}

/** ISO 周号（仅用于默认文件名） */
function isoWeek(date) {
  const d = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate()));
  const day = d.getUTCDay() || 7;
  d.setUTCDate(d.getUTCDate() + 4 - day);
  const y0 = new Date(Date.UTC(d.getUTCFullYear(), 0, 1));
  return { year: d.getUTCFullYear(), week: Math.ceil(((d - y0) / 86400000 + 1) / 7) };
}

/** 支持 `--from= --to= --out=`，也兼容旧写法 `[输出路径]` */
function parseArgs(argv) {
  const o = { from: '', to: '', out: '' };
  const pos = [];
  for (const a of argv.slice(2)) {
    if (a.startsWith('--from=')) o.from = a.slice(7);
    else if (a.startsWith('--to=')) o.to = a.slice(5);
    else if (a.startsWith('--out=')) o.out = a.slice(6);
    else pos.push(a);
  }
  if (pos[0]) o.out = pos[0];
  const w = thisWeek();
  o.from = o.from || w.from;
  o.to = o.to || w.to;
  if (!o.out) {
    const iw = isoWeek(new Date(o.to));
    o.out = path.join(REPO_ROOT, 'delivery/projects/hw-spring-mes/output/IT事项_' + iw.year + 'W' + iw.week + '.xlsx');
  }
  return o;
}

async function main() {
  const args = parseArgs(process.argv);
  const issues = [];
  const notes = [];
  const items = collect(args.from, args.to, issues, notes);

  if (!items.length) {
    console.log('⚠️  ' + args.from + ' ~ ' + args.to + ' 区间内无任何事项入选。');
    console.log('   （入选需满足：本期新增 / 本期闭环 / 本期日志关联 三者之一）');
    process.exit(2);
  }

  const outPath = args.out;
  const wb = buildWorkbook(buildITRows(items));
  const tmp = XLSX.write(wb, { type: 'buffer', bookType: 'xlsx' });
  const finalBuf = await inject(tmp);
  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, finalBuf);
  console.log('✅ ' + outPath);
  console.log('   区间: ' + args.from + ' ~ ' + args.to);

  const ok = verify(outPath);

  // 复核数据验证确实写进去了
  const zip = await JSZip.loadAsync(fs.readFileSync(outPath));
  const xml = await zip.file('xl/worksheets/sheet1.xml').async('string');
  const m = xml.match(/<dataValidations[\s\S]*?<\/dataValidations>/);
  const n = m ? (m[0].match(/<dataValidation /g) || []).length : 0;
  console.log('  下拉列表: ' + n + ' 个 ' + (n === DV_RANGES.length ? '✅' : '❌'));
  if (m) console.log('    ' + DV_RANGES.map(([c]) => c + '列').join(' / '));

  // ── 人工复核清单 ──
  console.log('\n── 入选理由 / 优先级核对 ──');
  items.forEach(o => {
    console.log('  ' + String(o.no).padStart(2) + '. [' + o._why + '] ' + o.desc.slice(0, 34)
      + '\n      影响' + (o.impact || '—') + ' × 紧急' + (o.urgency || '—') + ' → 矩阵推 ' + (o._p || '—')
      + (o._taskP ? ' ｜ 任务池记 ' + o._taskP + (o._taskP === o._p ? ' ✓' : ' ⚠️') : ' ｜ 任务池无优先级'));
  });

  const blank = items.filter(o => !o.company || !o.app);
  const noProp = items.filter(o => !o.proposer);
  if (blank.length) {
    console.log('\n⚠️  提出公司/应用分类留空，需你指定:');
    blank.forEach(o => console.log('   ' + o.no + '. ' + o.desc.slice(0, 30) + '（' + o._ev + '）'));
  }
  if (noProp.length) {
    console.log('\n⚠️  提出人为空 ' + noProp.length + ' 条：源任务池无该字段，');
    console.log('   而「提出人」是事实断言（不是排序单位元），**按契约禁止兜底** → 只能你补。');
    const bySrc = {};
    noProp.forEach(o => { (bySrc[o._src || '(无来源)'] = bySrc[o._src || '(无来源)'] || []).push(o.no); });
    console.log('   按「问题来源」分组，可整批填：');
    Object.entries(bySrc).forEach(([s, nos]) => console.log('     ' + s + ' → 第 ' + nos.join('/') + ' 行'));
  }
  if (notes.length) { console.log('\n── 推导提示（剔除 / 档位修正 / 留空）──'); [...new Set(notes)].forEach(s => console.log('  · ' + s)); }
  if (issues.length) { console.log('\n── 映射提示 ──'); [...new Set(issues)].forEach(s => console.log('  · ' + s)); }

  if (!ok || n !== DV_RANGES.length) process.exit(1);
}

if (require.main === module) {
  main().catch(e => { console.error('❌ ' + e.message); process.exit(1); });
}

module.exports = { buildWorkbook, buildITRows, inject, verify, collect, mapTask, CAT_ROWS, DATA_VALIDATIONS };
