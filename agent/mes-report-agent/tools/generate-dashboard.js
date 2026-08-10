#!/usr/bin/env node
/** generate-dashboard.js — 从本地 worklog 生成 HTML 仪表盘（ECharts，浏览器打开）
 *
 * 用法: node agent/mes-report-agent/tools/generate-dashboard.js [输出路径]
 *   默认输出: delivery/projects/hw-spring-mes/output/dashboard.html
 * 图表库: ECharts CDN（需联网；本地页面，非 artifact）
 * 数据: 本地 worklog/ 全量（task-pool.json + logs/YYYY-MM.json）
 */
'use strict';
const fs = require('fs');
const path = require('path');

const WORKLOG = path.join(__dirname, '..', 'data', 'worklog');
const LOGS_DIR = path.join(WORKLOG, 'logs');
const TASK_FILE = path.join(WORKLOG, 'task-pool.json');
const OUT_DEFAULT = path.join(__dirname, '..', '..', '..', 'delivery', 'projects', 'hw-spring-mes', 'output', 'dashboard.html');
const OUT = process.argv[2] ? path.resolve(process.argv[2]) : OUT_DEFAULT;

// 今天（本地时区）
const now = new Date();
const p2 = (n) => String(n).padStart(2, '0');
const today = now.getFullYear() + '-' + p2(now.getMonth() + 1) + '-' + p2(now.getDate());

function readLogs() {
  const logs = [];
  if (fs.existsSync(LOGS_DIR)) {
    for (const f of fs.readdirSync(LOGS_DIR).sort()) {
      if (!f.endsWith('.json')) continue;
      const arr = JSON.parse(fs.readFileSync(path.join(LOGS_DIR, f), 'utf8'));
      logs.push(...arr);
    }
  }
  return logs;
}
const tasks = fs.existsSync(TASK_FILE) ? JSON.parse(fs.readFileSync(TASK_FILE, 'utf8')) : [];
const logs = readLogs();

// ===== 计算指标 =====
const done = (t) => t['任务状态'] === '已闭环';
const isP1Open = (t) => t['优先级'] === 'P1' && !done(t);
const isOverdue = (t) => { const due = t['计划完成日期']; return due && due < today && !done(t); };

const kpi = {
  totalTask: tasks.length,
  doing: tasks.filter(t => t['任务状态'] === '进行中').length,
  done: tasks.filter(done).length,
  pending: tasks.filter(t => t['任务状态'] === '待启动').length,
  p1Open: tasks.filter(isP1Open).length,
  overdue: tasks.filter(isOverdue).length,
  totalLog: logs.length,
};

// 本周日志（周一~周日）
const wStart = new Date(now); wStart.setDate(now.getDate() - ((now.getDay() + 6) % 7));
const wStartStr = wStart.getFullYear() + '-' + p2(wStart.getMonth() + 1) + '-' + p2(wStart.getDate());
const weekLogs = logs.filter(l => (l['记录日期'] || '') >= wStartStr && (l['记录日期'] || '') <= today);

// ① 各项目健康度（任务池）
const PROJECTS = ['三厂小簧sMES', '一厂大簧sMES', '二厂大簧sMES', '重庆sMES项目', '实验室Lims项目', '无锡泽根sMES项目', '华纬其它项目'];
function health() {
  const rows = PROJECTS.map(proj => {
    const ts = tasks.filter(t => t['对应项目'] === proj);
    return {
      name: proj.replace('sMES', '').replace('项目', '').replace('华纬其它', '其它'),
      total: ts.length,
      doing: ts.filter(t => t['任务状态'] === '进行中').length,
      done: ts.filter(done).length,
    };
  }).filter(r => r.total > 0);
  return rows;
}

// ② P1-P4 未闭环分布
function priDist() {
  const open = tasks.filter(t => !done(t));
  return ['P1', 'P2', 'P3', 'P4'].map(p => ({ name: p, value: open.filter(t => t['优先级'] === p).length }));
}

// ③ 业务模块工作分布（日志业务模块字段）
function moduleDist() {
  const m = {};
  for (const l of logs) {
    const mod = l['业务模块'] || '未分类';
    m[mod] = (m[mod] || 0) + 1;
  }
  return Object.entries(m).map(([name, value]) => ({ name, value })).sort((a, b) => b.value - a.value);
}

// ④ 月度日志趋势
function monthlyTrend() {
  const months = {};
  for (const l of logs) {
    const m = (l['记录日期'] || '').slice(0, 7);
    if (m) months[m] = (months[m] || 0) + 1;
  }
  const ms = Object.keys(months).sort();
  return { months: ms, values: ms.map(m => months[m]) };
}

// ⑤ 项目×状态堆叠
function projStatus() {
  const sts = ['进行中', '待启动', '暂缓', '已闭环'];
  const rows = PROJECTS.map(proj => {
    const ts = tasks.filter(t => t['对应项目'] === proj);
    if (!ts.length) return null;
    return {
      name: proj.replace('sMES', '').replace('项目', '').replace('华纬其它', '其它'),
      data: sts.map(s => ts.filter(t => t['任务状态'] === s).length),
    };
  }).filter(Boolean);
  return { names: rows.map(r => r.name), statuses: sts, rows };
}

// 重点待协调
const needCoord = tasks.filter(t => (t['协调资源需求'] || '').trim() && !done(t));
// 近期到期（今天起 7 天内未闭环）
const soon = tasks.filter(t => { const due = t['计划完成日期']; return due && due >= today && due <= addDays(today, 7) && !done(t); }).sort((a, b) => a['计划完成日期'].localeCompare(b['计划完成日期']));

function addDays(dateStr, n) {
  const d = new Date(dateStr + 'T00:00:00'); d.setDate(d.getDate() + n);
  return d.getFullYear() + '-' + p2(d.getMonth() + 1) + '-' + p2(d.getDate());
}

// P1 预警明细
const p1List = tasks.filter(isP1Open).sort((a, b) => (a['计划完成日期'] || '9999').localeCompare(b['计划完成日期'] || '9999'));

// ===== 内联数据（JSON 安全转义 </script>）=====
const esc = (o) => JSON.stringify(o).replace(/</g, '\\u003c');
const DATA = {
  generated: today, kpi: { ...kpi, weekLogs: weekLogs.length },
  health: health(), priDist: priDist(), moduleDist: moduleDist(),
  trend: monthlyTrend(), projStatus: projStatus(),
  needCoord: needCoord.map(t => ({ title: t['归集标题'], need: t['协调资源需求'], due: t['计划完成日期'] || '', pri: t['优先级'] })),
  soon: soon.map(t => ({ title: t['归集标题'], due: t['计划完成日期'], pri: t['优先级'] })),
  p1: p1List.map(t => ({ title: t['归集标题'], proj: t['对应项目'], due: t['计划完成日期'] || '无期限', need: t['协调资源需求'] || '' })),
};

const html = `<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MES 项目管理驾驶舱</title>
<script src="https://cdn.jsdelivr.net/npm/echarts@5.5.1/dist/echarts.min.js"></script>
<style>
:root{
  --navy:#1F4E79; --blue:#2E75B6; --light:#F2F7FC; --line:#D9E2EC;
  --red:#C00000; --yellow:#B26B00; --green:#2E7D32; --gray:#6B7280;
}
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:"Microsoft YaHei","微软雅黑",sans-serif;background:#EFF3F8;color:#1F2937;padding:20px}
header{display:flex;align-items:center;justify-content:space-between;margin-bottom:16px;flex-wrap:wrap;gap:8px}
header h1{color:var(--navy);font-size:22px;font-weight:700}
header .meta{color:var(--gray);font-size:13px}
.kpis{display:grid;grid-template-columns:repeat(auto-fit,minmax(150px,1fr));gap:12px;margin-bottom:16px}
.kpi{background:#fff;border-radius:10px;padding:14px 16px;box-shadow:0 1px 3px rgba(0,0,0,.06);border-left:4px solid var(--blue)}
.kpi .num{font-size:26px;font-weight:700;color:var(--navy);line-height:1.2}
.kpi .lbl{font-size:12px;color:var(--gray);margin-top:2px}
.kpi.red{border-left-color:var(--red)} .kpi.red .num{color:var(--red)}
.kpi.green{border-left-color:var(--green)} .kpi.green .num{color:var(--green)}
.kpi.yellow{border-left-color:var(--yellow)} .kpi.yellow .num{color:var(--yellow)}
.p1-banner{background:#FDE9E9;border:1px solid #F5C6C6;border-radius:10px;padding:12px 16px;margin-bottom:16px}
.p1-banner .t{color:var(--red);font-weight:700;font-size:14px;margin-bottom:6px}
.p1-banner ul{list-style:none}
.p1-banner li{font-size:13px;color:#7A1F1F;padding:3px 0;border-bottom:1px dashed #F0C9C9}
.p1-banner li:last-child{border-bottom:none}
.grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(430px,1fr));gap:14px;margin-bottom:16px}
.card{background:#fff;border-radius:10px;padding:14px 16px;box-shadow:0 1px 3px rgba(0,0,0,.06)}
.card h3{font-size:14px;color:var(--navy);margin-bottom:8px;border-left:3px solid var(--blue);padding-left:8px}
.chart{width:100%;height:300px}
.list{list-style:none}
.list li{font-size:13px;padding:7px 0;border-bottom:1px solid var(--line);display:flex;align-items:center;gap:8px;flex-wrap:wrap}
.list li:last-child{border-bottom:none}
.pill{font-size:11px;font-weight:700;border-radius:4px;padding:1px 6px;color:#fff}
.pill.P1{background:var(--red)} .pill.P2{background:var(--yellow)} .pill.P3{background:var(--gray)} .pill.P4{background:#9CA3AF}
.pill.due{background:var(--blue)}
.title{font-weight:600;color:#1F2937}
.sub{color:var(--gray);font-size:12px}
@media(max-width:900px){.grid{grid-template-columns:1fr}}
</style>
</head>
<body>
<header>
  <h1>📊 MES 项目管理驾驶舱</h1>
  <div class="meta">数据截至 ${DATA.generated} · 本地工作日志生成（worklog/）</div>
</header>

<div class="kpis">
  <div class="kpi"><div class="num">${DATA.kpi.totalTask}</div><div class="lbl">任务池总数</div></div>
  <div class="kpi"><div class="num">${DATA.kpi.doing}</div><div class="lbl">进行中</div></div>
  <div class="kpi green"><div class="num">${DATA.kpi.done}</div><div class="lbl">已闭环</div></div>
  <div class="kpi"><div class="num">${DATA.kpi.pending}</div><div class="lbl">待启动</div></div>
  <div class="kpi red"><div class="num">${DATA.kpi.p1Open}</div><div class="lbl">P1 未闭环</div></div>
  <div class="kpi yellow"><div class="num">${DATA.kpi.overdue}</div><div class="lbl">已延期</div></div>
  <div class="kpi"><div class="num">${DATA.kpi.totalLog}</div><div class="lbl">日志总量</div></div>
  <div class="kpi"><div class="num">${DATA.kpi.weekLogs}</div><div class="lbl">本周日志</div></div>
</div>

<div class="p1-banner">
  <div class="t">⚠ P1 高风险（${DATA.p1.length} 项未闭环）</div>
  <ul>
    ${DATA.p1.map(x => '<li>【' + x.proj + '】' + x.title + '（' + x.due + '）' + (x.need ? ' · 需协调：' + x.need : '') + '</li>').join('')}
  </ul>
</div>

<div class="grid">
  <div class="card"><h3>各项目健康度</h3><div class="chart" id="c-health"></div></div>
  <div class="card"><h3>优先级风险分布（未闭环）</h3><div class="chart" id="c-pri"></div></div>
  <div class="card"><h3>业务模块工作分布</h3><div class="chart" id="c-module"></div></div>
  <div class="card"><h3>月度日志趋势</h3><div class="chart" id="c-trend"></div></div>
  <div class="card"><h3>项目 × 任务状态</h3><div class="chart" id="c-status"></div></div>
  <div class="card"><h3>本周重点待协调</h3><ul class="list" id="coord"></ul></div>
</div>

<div class="grid">
  <div class="card"><h3>近 7 天到期任务</h3><ul class="list" id="soon"></ul></div>
</div>

<script>
var DATA = ${esc(DATA)};
var COLORS = { navy:'#1F4E79', blue:'#2E75B6', red:'#C00000', yellow:'#B26B00', green:'#2E7D32', gray:'#9CA3AF' };

// ① 各项目健康度
var ch1 = echarts.init(document.getElementById('c-health'));
ch1.setOption({
  tooltip:{trigger:'axis'},
  legend:{bottom:0, data:['总任务','进行中','已闭环']},
  grid:{left:10,right:10,top:30,bottom:40,containLabel:true},
  xAxis:{type:'category', data:DATA.health.map(d=>d.name)},
  yAxis:{type:'value', minInterval:1},
  series:[
    {name:'总任务', type:'bar', data:DATA.health.map(d=>d.total), itemStyle:{color:COLORS.blue}},
    {name:'进行中', type:'bar', data:DATA.health.map(d=>d.doing), itemStyle:{color:COLORS.yellow}},
    {name:'已闭环', type:'bar', data:DATA.health.map(d=>d.done), itemStyle:{color:COLORS.green}},
  ]
});

// ② 优先级分布
var ch2 = echarts.init(document.getElementById('c-pri'));
ch2.setOption({
  tooltip:{trigger:'item', formatter:'{b}: {c} 项 ({d}%)'},
  legend:{bottom:0},
  series:[{
    type:'pie', radius:['45%','70%'], center:['50%','46%'],
    label:{formatter:'{b}\\n{c} 项'},
    data:DATA.priDist.map(function(x){
      var c = x.name==='P1'?COLORS.red : x.name==='P2'?COLORS.yellow : x.name==='P3'?COLORS.blue : '#C7CBCF';
      return {name:x.name, value:x.value, itemStyle:{color:c}};
    })
  }]
});

// ③ 业务模块分布
var ch3 = echarts.init(document.getElementById('c-module'));
ch3.setOption({
  tooltip:{trigger:'axis'},
  grid:{left:10,right:40,top:10,bottom:10,containLabel:true},
  xAxis:{type:'value', minInterval:1},
  yAxis:{type:'category', data:DATA.moduleDist.map(d=>d.name).reverse()},
  series:[{type:'bar', data:DATA.moduleDist.map(d=>d.value).reverse(), itemStyle:{color:COLORS.blue}, barWidth:'55%'}]
});

// ④ 月度日志趋势
var ch4 = echarts.init(document.getElementById('c-trend'));
ch4.setOption({
  tooltip:{trigger:'axis'},
  grid:{left:10,right:20,top:20,bottom:20,containLabel:true},
  xAxis:{type:'category', data:DATA.trend.months},
  yAxis:{type:'value', minInterval:1},
  series:[{name:'日志量', type:'line', smooth:true, data:DATA.trend.values,
    itemStyle:{color:COLORS.navy}, lineStyle:{color:COLORS.navy,width:3},
    areaStyle:{color:{type:'linear',x:0,y:0,x2:0,y2:1,colorStops:[{offset:0,color:'rgba(46,117,182,.35)'},{offset:1,color:'rgba(46,117,182,.02)'}]}}}]
});

// ⑤ 项目×状态
var ch5 = echarts.init(document.getElementById('c-status'));
ch5.setOption({
  tooltip:{trigger:'axis'},
  legend:{bottom:0, data:DATA.projStatus.statuses},
  grid:{left:10,right:10,top:30,bottom:40,containLabel:true},
  xAxis:{type:'category', data:DATA.projStatus.names},
  yAxis:{type:'value', minInterval:1},
  series:[
    {name:'进行中', type:'bar', stack:'t', data:DATA.projStatus.rows.map(r=>r.data[0]), itemStyle:{color:COLORS.blue}},
    {name:'待启动', type:'bar', stack:'t', data:DATA.projStatus.rows.map(r=>r.data[1]), itemStyle:{color:'#B7C9DB'}},
    {name:'暂缓',   type:'bar', stack:'t', data:DATA.projStatus.rows.map(r=>r.data[2]), itemStyle:{color:'#E0A58C'}},
    {name:'已闭环', type:'bar', stack:'t', data:DATA.projStatus.rows.map(r=>r.data[3]), itemStyle:{color:COLORS.green}},
  ]
});

// ⑥ 本周重点待协调
var coordEl = document.getElementById('coord');
if (DATA.needCoord.length === 0) coordEl.innerHTML = '<li class="sub">无待协调事项</li>';
else coordEl.innerHTML = DATA.needCoord.map(function(x){
  return '<li><span class="pill '+x.pri+'">'+x.pri+'</span><span class="title">'+x.title+'</span><span class="sub">需协调：'+x.need+'</span>'+(x.due?'<span class="pill due">'+x.due+'</span>':'')+'</li>';
}).join('');

// ⑦ 近7天到期
var soonEl = document.getElementById('soon');
if (DATA.soon.length === 0) soonEl.innerHTML = '<li class="sub">未来 7 天无到期任务</li>';
else soonEl.innerHTML = DATA.soon.map(function(x){
  return '<li><span class="pill '+x.pri+'">'+x.pri+'</span><span class="title">'+x.title+'</span><span class="pill due">'+x.due+'</span></li>';
}).join('');

window.addEventListener('resize', function(){
  [ch1,ch2,ch3,ch4,ch5].forEach(function(c){c.resize();});
});
</script>
</body>
</html>
`;

fs.mkdirSync(path.dirname(OUT), { recursive: true });
fs.writeFileSync(OUT, html, 'utf8');
console.log('✅ 仪表盘已生成 → ' + path.relative(process.cwd(), OUT));
console.log('   ' + DATA.kpi.totalTask + ' 任务 / ' + DATA.kpi.totalLog + ' 日志 / P1 未闭环 ' + DATA.kpi.p1Open + ' 项 / 本周日志 ' + DATA.kpi.weekLogs + ' 条');
