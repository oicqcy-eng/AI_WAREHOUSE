#!/usr/bin/env node
/** worklog-schema.js — worklog 字段与枚举契约的【唯一真源】
 *
 * 定位：
 *   运行时 —— worklog-append.js（写入校验）、worklog-server.js（/api/options 下发）
 *             均 require 本文件
 *   文档   —— data/worklog/SCHEMA.md、data/worklog-local.md、data/report-bitable-spec.md
 *             只写「N 项 + 指向本文件」的计数，不再复制值
 *
 * 【不变式】本文件不得 require 仓库内任何模块。它必须是无副作用的叶子：
 *   读文件是调用方的事（如 task-pool 的 _id 集合由 append 读好后作为参数传入）。
 *   一旦这里开始读文件，路径常量与 fs 错误处理会回流，最终必然 require append 而成环。
 *
 * 改枚举/字段/缺省值 → 只改这里，并同步文档里的「N 项」计数。
 *
 * 校验模式（环境变量 WORKLOG_ENUM_MODE=warn|strict，或各入口显式传 mode）：
 *   warn（默认）打印告警但照常写入 —— 契约落地期使用，不拦截存量合法外值
 *   strict      仅对 level='error' 的 issue 抛错阻断写入。
 *               切 strict 的判据：validate 报告里 legacy 桶清零（见 KNOWN_OUTSIDERS）
 */
'use strict';
const crypto = require('crypto');

const TODAY = (() => {
  const d = new Date(); const p = n => String(n).padStart(2, '0');
  return d.getFullYear() + '-' + p(d.getMonth() + 1) + '-' + p(d.getDate());
})();

// ============================================================
// 枚举（唯一真源）
// ============================================================

const OPTIONS = {
  // 厂区/系统粒度（客户级、项目级的横切事务归入「华纬其它项目」，见 worklog-local.md §2）
  projects: ['三厂小簧sMES', '一厂大簧sMES', '二厂大簧sMES', '重庆sMES项目', '实验室Lims项目', '无锡泽根sMES项目', '华纬其它项目'],
  // 仅用于界面显示的项目简称（原 worklog-ui.html PROJ_SHORT，2026-09-11 迁入）
  projectShort: { '三厂小簧sMES': '三厂小簧', '一厂大簧sMES': '一厂大簧', '二厂大簧sMES': '二厂大簧', '重庆sMES项目': '重庆', '实验室Lims项目': '实验室Lims', '无锡泽根sMES项目': '无锡泽根', '华纬其它项目': '华纬其它' },
  resultTypes: ['问题关闭', '方案确认', '配置完成', '培训完成', '数据完成', '上线验证', '风险暴露', '需求确认'],
  // 严格限定为 MES 功能模块，不承载「工作性质」（项目管理/项目汇报等）与非 MES 业务域
  modules: ['生产报工', '工单管理', '物料管控', '质量模块', '设备维保', '模治具管理', '安灯异常', '设备数采', '系统接口', '报表看板', '系统管理'],
  // 严格限定为「实施方法论阶段」，不承载项目生命周期状态（模拟筹备/实施运行/系统运行/上线运行）
  stages: ['需求调研', '方案设计', '基础资料收集', '培训上线', '现场实施', '运维优化'],
  priority: ['P1', 'P2', 'P3', 'P4'],
  taskStatus: ['待启动', '进行中', '暂缓', '已闭环'],
  sources: ['现场反馈', '系统异常', '用户需求', '会议决策', '领导要求', '审厂要求'],
  weekCat: ['本周完成', '本周推进', '重点问题', '下周计划', '长期跟踪'],
  yesNo: ['是', '否'],
};

// ============================================================
// 字段清单与必填（规范序，不含 _id）
// ============================================================

// 附件：数据实测存在（8 日志 / 53 任务）、worklog/README.md 与 SCHEMA.md 均已文档化，
// 此前漏在契约外 —— 补入。注意 export-excel.js 的列序是「协调资源需求,附件,卡点&问题描述」，
// 与本表序不同，故该工具的表头不得直接由本表派生（会改列序），只能断言「表头 ⊆ 本表」。
const LOG_FIELDS = ['记录日期', '所属项目', '工作内容', '结果类型', '是否形成任务', '业务模块', '项目阶段', '责任人', '关联任务', '协作人', '交付产出', '附件'];
const LOG_REQUIRED = ['记录日期', '所属项目', '工作内容', '结果类型', '是否形成任务'];
const TASK_FIELDS = ['归集标题', '对应项目', '问题来源', '优先级', '发现日期', '计划完成日期', '实际闭环日期', '任务状态', '进度百分比', '闭环判定标准', '周报归集分类', '协调资源需求', '卡点&问题描述', '附件'];
const TASK_REQUIRED = ['归集标题', '对应项目', '问题来源', '优先级'];

// ============================================================
// 缺省值（仅在「字段解读优先级」第 4 步——确实无信息时——使用）
// ============================================================

/** 2026-09-11 拍板：删除 `结果类型`/`业务模块`/`项目阶段` 三条缺省值。
 *
 *  划界判据：**兜底合法，当且仅当该值是该字段消费者的「排序/分组/状态机单位元」**——
 *  即「未判定」映射到它之后，所有下游读数的语义不变。若该值是「关于世界的事实断言」，
 *  兜底即伪造。
 *
 *  已删：结果类型（种类断言，曾吃掉 54.1%）、业务模块（种类断言）、项目阶段（阶段断言 46.5%）。
 *  其中 `结果类型` 仍是必填 —— 删缺省后调用方必须当场给出，给不出就报错（这才是有意义的摩擦）。
 *  保留：是否形成任务=否（保守否定，不虚增任务池）、责任人（单人仓库，恒等于陈宇，属「声明式」兜底）、
 *        空串占位（协作人/交付产出）。
 *  遗留同类问题：`TASK_DEFAULTS['问题来源']='会议决策'` 是「证据出处断言」，性质与已删三条相同，
 *        但用户 2026-09-11 明确「只删已拍板的 3 条」，故本轮保留，留下一轮。 */
// 缺省值只放**非必填**字段：必填校验跑在补兜底之前，给必填字段配兜底永远是死代码
// （2026-09-12 实测：不传必填项直接抛错，兜底救不了），而留着的死兜底更危险 ——
// 将来谁把该字段移出 *_REQUIRED，这条伪造兜底会**突然激活**。
// 已据此删除两条：`是否形成任务='否'`、`问题来源='会议决策'`。
const LOG_DEFAULTS = {
  '责任人': '陈宇', '协作人': '', '交付产出': '',
};
const TASK_DEFAULTS = {
  '任务状态': '待启动', '周报归集分类': '长期跟踪',
  '发现日期': TODAY, '计划完成日期': '', '实际闭环日期': '', '进度百分比': '',
  '闭环判定标准': '', '协调资源需求': '', '卡点&问题描述': '',
};

// ============================================================
// 稳定 _id
// ============================================================

const ID_RE = { log: /^L-[0-9a-f]{10}$/, task: /^T-[0-9a-f]{10}$/ };

/** date+content+idx 哈希，确定性（同一条记录永远同一个 id）。
 *  注意 idx 是**创建时**数组长度，落盘后记录被 sort() 重排 → idx 无法从记录内容反推，
 *  故「重算 _id 校验」不可行（必大面积误报），不要试图加这条规则。 */
function makeId(prefix, rec, idx) {
  const key = rec['记录日期'] || rec['发现日期'] || rec['归集标题'] || rec['工作内容'] || '';
  const content = rec['工作内容'] || rec['归集标题'] || '';
  return prefix + '-' + crypto.createHash('sha1').update(key + '|' + content + '|' + idx).digest('hex').slice(0, 10);
}

/** `_id` 三层诊断。level 随路径不同（见 validateRecord 的 opts.idLevel）：
 *  Tier1  格式不符 —— append 路径 error（strict 可阻断）、update/delete 路径 warn；
 *         update/delete 的 _id 是**查找键不是数据**，若当 error，存量 T-260911a 这类记录会变得不可编辑。
 *  Tier2  后缀编码了记录自身日期 —— sha1 产物不可能恰好以自身日期开头（概率 ~16^-8），故零误报。
 *         **这是唯一能抓住 `L-2026091001` 这类手工编号的检查**：它是 10 位且全为十六进制字符
 *         （0-9 属 [0-9a-f]），所以 Tier1 对 2026-09 的批量补录几乎完全失效。
 *  Tier3  低熵（10 位纯数字 / 单字符重复）—— 均匀 hex 下 10 位纯数字概率 (10/16)^10≈0.9%，
 *         488 条里期望约 4 条误报，故只给 info，不进 strict。
 */
function idIssues(rec, kind, idLevel) {
  const id = rec['_id'];
  if (!id) return [];
  const prefix = kind === 'log' ? 'L' : 'T';
  const out = [];
  if (!ID_RE[kind].test(id)) {
    out.push({ class: 'id', level: idLevel, field: '_id', value: id,
      msg: '_id「' + id + '」不符合规范（应为 ' + prefix + '- 加 10 位十六进制小写）' });
    return out;
  }
  const soft = idLevel === 'error' ? 'warn' : 'info'; // 非 append 路径不因 _id 形态打扰使用者
  const suffix = id.slice(prefix.length + 1);
  const own = String(rec['记录日期'] || rec['发现日期'] || '').replace(/-/g, '');
  if (own.length === 8 && suffix.slice(0, 8) === own) {
    out.push({ class: 'id', level: soft, field: '_id', value: id,
      msg: '_id「' + id + '」后缀即记录自身日期，疑手工编号（绕开了写入工具，或显式传入了 _id）' });
  } else if (/^\d{10}$/.test(suffix) || /^(.)\1{9}$/.test(suffix)) {
    out.push({ class: 'id', level: 'info', field: '_id', value: id,
      msg: '_id「' + id + '」低熵，疑似手填' });
  }
  return out;
}

// ============================================================
// 校验
// ============================================================

/** 记录字段 → OPTIONS 键 的映射（枚举校验的字段范围由此决定） */
const ENUM_FIELDS = {
  log: { '所属项目': 'projects', '结果类型': 'resultTypes', '业务模块': 'modules', '项目阶段': 'stages', '是否形成任务': 'yesNo' },
  task: { '对应项目': 'projects', '问题来源': 'sources', '优先级': 'priority', '任务状态': 'taskStatus', '周报归集分类': 'weekCat' },
};

/**
 * 三类校验：① 枚举成员性 ② `_id` 规范性 ③ `关联任务` 引用存在性
 *
 * 返回**完整 issue 列表，绝不在内部读 mode** —— 报不报由调用方定。否则 warn 模式会把问题吞掉，
 * `validate` 子命令就无法复用同一套逻辑，等于维护两份真相。
 *
 * @param {'log'|'task'} kind
 * @param {object} rec   待校验记录（update 路径传「原记录 + patch」合并后的结果）
 * @param {object} [opts]
 * @param {string[]} [opts.onlyKeys] 仅校验这些键（update 路径传 patch 的键）。
 *        理由：update 是部分字段合并，若校验整条，任何无关编辑都会把该条的历史遗留外值重报一遍，
 *        噪声淹没信号，且编辑者当场修不了（它不在 patch 里）。注意**保护不了 UI 路径**——
 *        worklog-ui.html 的 saveLog 每次提交全字段，patch 恒等于全字段；那条路径靠 KNOWN_OUTSIDERS 降噪。
 * @param {Set<string>} [opts.taskIds] 任务池 _id 集合；不传则跳过引用校验（本文件不读文件）
 * @param {'error'|'warn'} [opts.idLevel] `_id` 格式不符的级别。append 传 'error'（strict 可阻断），
 *        update/delete 传 'warn'（查找键，不能阻断存量记录的编辑）。默认 'warn'。
 * @returns {Array<{class:string, level:string, field:string, value:string, msg:string}>}
 */
function validateRecord(kind, rec, opts) {
  const o = opts || {};
  const only = o.onlyKeys ? new Set(o.onlyKeys) : null;
  const inScope = f => !only || only.has(f);
  const issues = [];

  // ① 枚举成员性。空值不算违规 —— 留空是允许的，且优于伪造（见 LOG_DEFAULTS 注释）。
  const map = ENUM_FIELDS[kind] || {};
  for (const field of Object.keys(map)) {
    if (!inScope(field)) continue;
    const v = rec[field];
    if (v === undefined || v === null || v === '') continue;
    const allowed = OPTIONS[map[field]];
    if (!allowed.includes(v)) {
      const known = OUTSIDERS[field];
      const isKnown = known && Object.prototype.hasOwnProperty.call(known, v);
      issues.push({
        // 已知存量外值 → legacy（永不阻断）；未知值 → error（可被 strict 阻断）。
        // 区分二者的意义：strict 要拦的是"这次写入**新引入**的越界值"，而不是编辑一条
        // 历史记录时把库里既有的 94 条外值再报一遍（那种编辑者当场也修不了）。
        // 这也让「切 strict 的判据 = legacy 桶清零」自洽 —— 清零后任何枚举违规都是新的。
        // 默认 error 而非 warn：未知枚举值在任何调用方眼里都是缺陷，唯一该降级的情形
        // 就是"已知存量外值"（已单独成 legacy 桶）。默认值即真源，避免 8 个调用点
        // 各传一次标志、漏传一个就静默失效 —— 那正是本轮要消灭的漂移形态。
        class: 'enum', level: isKnown ? 'legacy' : (o.enumLevel || 'error'), field, value: v,
        msg: field + ' 取值「' + v + '」不在枚举内'
          + (isKnown ? '（已知外值，待存量治理；建议 ' + known[v] + '）' : '（合法 ' + allowed.length + ' 项）'),
      });
    }
  }

  // ② _id 规范性
  if (o.checkId !== false) issues.push(...idIssues(rec, kind, o.idLevel || 'warn'));

  // ③ 关联任务引用存在性（仅日志有此字段）
  //    该字段是**逗号分隔多值**（实测 20 条带值中 5 条是多值）——必须先拆分再逐个比对，
  //    否则 `T-e221e0264d,T-f312d0f57f` 会被当成一整个 id，凭空制造大量误报。
  if (kind === 'log' && inScope('关联任务') && o.taskIds) {
    const raw = rec['关联任务'];
    if (raw) {
      String(raw).split(/[,，、;；\s]+/).map(s => s.trim()).filter(Boolean).forEach(t => {
        if (o.taskIds.has(t)) return;
        const looksLikeId = /^[LT]-[0-9a-zA-Z]+$/.test(t);
        issues.push({
          class: 'ref', level: looksLikeId ? 'warn' : 'info', field: '关联任务', value: t,
          msg: looksLikeId
            ? '关联任务「' + t + '」在任务池中不存在（可能是错字，或任务尚未创建）'
            : '关联任务「' + t + '」不是 _id 形态，无法校验引用（疑似自由文本）',
        });
      });
    }
  }

  return issues;
}

/** 必填存在性（独立于 validateRecord —— 必填是**硬不变量**，任何模式下都阻断，不受 warn/strict 影响）
 *  @param {string[]} [onlyKeys] update 路径传 patch 的键：只拦「本次把必填项改空」，
 *         不拦存量记录里本就为空的必填项（实测 `结果类型` 空 54 条，否则这 54 条将永远无法编辑）。
 *  @returns {string[]} 缺失字段名 */
function missingRequired(kind, rec, onlyKeys) {
  const req = kind === 'log' ? LOG_REQUIRED : TASK_REQUIRED;
  const only = onlyKeys ? new Set(onlyKeys) : null;
  return req.filter(k => (!only || only.has(k)) && !rec[k]);
}

/** 必填缺失的错误消息；枚举型必填字段附带可选值，让调用方当场能补齐（可执行的报错） */
function requiredMessage(kind, rec, onlyKeys) {
  const miss = missingRequired(kind, rec, onlyKeys);
  if (!miss.length) return null;
  const hintOf = { '结果类型': 'resultTypes', '问题来源': 'sources', '所属项目': 'projects', '对应项目': 'projects' };
  const hints = miss.map(f => {
    const key = hintOf[f];
    return key ? f + '（可选: ' + OPTIONS[key].join('/') + '）' : f;
  });
  return (kind === 'log' ? '日志' : '任务') + '缺少必填字段: ' + hints.join('；');
}

function resolveMode(override) {
  const m = String(override || process.env.WORKLOG_ENUM_MODE || 'warn').toLowerCase();
  return m === 'strict' ? 'strict' : 'warn';
}

/** 写盘前调用：warn 打印后放行；strict 仅对 level='error' 抛错。
 *  legacy（已知外值）与 info（诊断）在写入路径**不打印** —— 它们只进 validate 报告，
 *  否则 UI 每次提交全字段、或 CLI 编辑一条历史记录，都会刷屏并把真实信号淹掉。 */
function applyValidation(issues, mode, label) {
  if (!issues || !issues.length) return;
  if (mode === 'strict') {
    const blocking = issues.filter(i => i.level === 'error');
    if (blocking.length) {
      throw new Error('契约校验未通过（strict 模式，已阻断写入）:\n' + blocking.map(i => '   · ' + i.msg).join('\n'));
    }
  }
  const show = issues.filter(i => i.level === 'error' || i.level === 'warn');
  if (show.length) {
    // 模式字样必须取自实际 mode：硬编码 'warn 模式' 会在 strict 下谎报（strict 放行的是
    // 非 error 级 issue，此时如实说明"未阻断"才不会让人以为 strict 没生效）。
    console.error('⚠️  worklog 契约告警（' + mode + ' 模式，' + (mode === 'strict' ? '无 error 级，未阻断' : '仍已写入') + '）'
      + (label ? ' [' + label + ']' : '') + ':\n'
      + show.map(i => '   · ' + i.msg).join('\n'));
  }
}

// ============================================================
// 已知枚举外值（2026-09-11 实测导出，非推测）
// ============================================================

/** 命中即 level='legacy'：写入路径不打印，仅在 validate 报告单独成桶。
 *  存在理由：UI 的 saveLog 每次提交全字段，`所属项目` 永远在 patch 里 —— 没有这张表，
 *  每编辑一条历史记录都会告警，告警疲劳会直接摧毁校验的可信度。
 *  这张表有**死亡条件**：strict 的切换判据 = validate 报告中 legacy 桶清零。届时本表随之删除。
 *  （清单由全量扫描导出：所属项目 8 类/19 条、结果类型 5 类/21 条、业务模块 10 类/27 条、
 *    项目阶段 8 类/41 条、对应项目 2 类/4 条、问题来源 2 类/5 条、周报归集分类 1 类/1 条） */
const PROJECT_OUTSIDERS = {
  '重庆MES项目': '重庆sMES项目（同厂区别名）',
  '三厂小簧MES项目': '三厂小簧sMES（同厂区别名）',
  'hw-spring-mes': '华纬其它项目（目录名误当项目名）',
  '华纬MES项目': '华纬其它项目（项目级横切）',
  '华纬MES项目-项目级': '华纬其它项目（项目级横切）',
  '华纬MES项目总体': '华纬其它项目（项目级横切）',
  '共用项目-华纬MES实施运维': '华纬其它项目（项目级横切）',
  'AI-WAREHOUSE仓库': '（非客户项目，需人工确认）',
};
const OUTSIDERS = {
  '所属项目': PROJECT_OUTSIDERS,
  '对应项目': PROJECT_OUTSIDERS,
  '结果类型': {
    '知识沉淀': '（工作性质；已由结果类型外的语义承载，建议留空）',
    '数据完善': '数据完成（同义）',
    '数据修正': '数据完成（同义）',
    '会议纪要': '（工作性质，建议留空）',
    '计划完成': '方案确认 / 知识沉淀（需人工确认；该条 _id 疑手写）',
  },
  '业务模块': {
    '报工管理': '生产报工（报表口径类可议报表看板）',
    '生产模型': '拆分：学习沉淀类→留空；产品/控制计划类→需人工确认',
    '项目管理': '（工作性质，建议留空）',
    '模拟测试': '（工作性质，建议留空）',
    '项目汇报': '（工作性质，建议留空）',
    '仓库运维': '（非 MES 业务域，建议留空）',
    'IT服务管理': '（非 MES 业务域，建议留空）',
    '培训': '（工作性质，结果类型=培训完成 已覆盖）',
    '报告管理': '报表看板 或留空（需人工确认）',
    '生产计划': '（工作性质，需人工确认）',
  },
  '项目阶段': {
    '模拟筹备': '（项目生命周期状态，不是实施阶段，建议留空）',
    '模拟仿真筹备': '（项目生命周期状态，不是实施阶段，建议留空）',
    '实施运行': '（项目生命周期状态；按记录动作归一 → 现场实施 / 运维优化）',
    '系统运行': '（项目生命周期状态；与「实施运行」语义重叠，需人工确认）',
    '上线运行': '培训上线（需人工确认）',
    '学习沉淀': '（工作性质，建议留空）',
    '工具配置': '（工作性质，建议留空）',
    '流程建设': '（工作性质，建议留空）',
  },
  '问题来源': {
    '问题管制表': '现场反馈 / 会议决策（载体≠渠道，不宜收编为枚举）',
    '用户投放': '用户需求',
  },
  '周报归集分类': { '本周进行': '本周推进（疑似笔误）' },
};

/** 实测在用、但**不是**契约成员的扩展值（由 OUTSIDERS 派生，不再单独维护）
 *  printSchema 曾把它当「实测扩展」教给写入方，是同一个洞的泄漏点 —— 已改为只指向 validate。 */
const RESULT_TYPES_EXTRA = Object.keys(OUTSIDERS['结果类型']);

/** 契约计数摘要（供验证与文档同步用） */
function summary() {
  const counts = [
    ['所属项目', OPTIONS.projects.length], ['结果类型', OPTIONS.resultTypes.length],
    ['业务模块', OPTIONS.modules.length], ['项目阶段', OPTIONS.stages.length],
    ['优先级', OPTIONS.priority.length], ['任务状态', OPTIONS.taskStatus.length],
    ['问题来源', OPTIONS.sources.length], ['周报归集分类', OPTIONS.weekCat.length],
  ];
  return counts.map(([k, v]) => k + ' ' + v + ' 项').join(' · ');
}

module.exports = {
  OPTIONS, RESULT_TYPES_EXTRA, OUTSIDERS,
  LOG_FIELDS, LOG_REQUIRED, TASK_FIELDS, TASK_REQUIRED,
  LOG_DEFAULTS, TASK_DEFAULTS,
  ID_RE, ENUM_FIELDS, TODAY,
  makeId, idIssues, validateRecord, missingRequired, requiredMessage,
  resolveMode, applyValidation, summary,
};
