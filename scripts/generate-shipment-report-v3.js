#!/usr/bin/env node
/**
 * generate-shipment-report-v3.js
 * 三厂数采整体追踪汇报 v3 - 基于原始调研表col30纠偏
 *
 * 纠偏逻辑：
 *   原始调研表 col30（华纬待解决问题描述）= 空 → 华纬无待办 → 鼎捷可正常推进
 *   原始调研表 col30 非空 → 华纬有待办 → 需华纬先解决
 */
'use strict';
const XLSX = require('../agent/mes-report-agent/node_modules/xlsx');
const path = require('path');

// ========== 读取樊正毅管控表 S1 ==========
const wb_ctrl = XLSX.readFile('delivery/inbox/华纬三厂小簧数采推进事项管控表_确认版(1)-樊正毅9月14日更新版.xlsx');
const raw_ctrl = XLSX.utils.sheet_to_json(wb_ctrl.Sheets['数采推进事项管控表'], {header:1, defval:''});

function extractBlock(startIdx, endIdx) {
  const arr = [];
  for(let i=startIdx; i<endIdx; i++){
    const r = raw_ctrl[i];
    if(!r) continue;
    const s = String(r[0]);
    if(s.match(/^\d+$/) && r[1] && r[1]!=='甲方设备负责人' && r[1]!=='鼎捷' && r[5]) {
      arr.push({
        seq: Number(r[0]), code: r[2]||'', name: r[1]||'', brand: r[3]||'',
        method: r[4]||'', pointCollection: r[6]||'',
        huaweiIssue: r[7]||'', dingjieIssue: r[8]||'',
        resolution: r[9]||'', remark: r[10]||''
      });
    }
  }
  return arr;
}
const s1 = extractBlock(5, 44);
const s2 = extractBlock(46, 48);
const s3 = extractBlock(50, 96);
const s4 = extractBlock(98, 158);

// ========== 读取原始调研表，建立 code -> 华纬问题 映射 ==========
const wb_orig = XLSX.readFile('delivery/inbox/原始版不要动--1.设备调研评估表-华纬三厂 (含点表收集和盒子安装状态)20260806v6.xlsx');
const raw_orig = XLSX.utils.sheet_to_json(wb_orig.Sheets['华纬3厂清单（251209）'], {header:1, defval:''});
const origMap = {};
for(let i=6; i<raw_orig.length; i++){
  const r = raw_orig[i];
  if(!r[0] || String(r[0]).trim()==='') continue;
  origMap[r[3]||''] = { huaweiIssue: r[30]||'', djIssue: r[35]||'' };
}

// ========== 纠偏分类 S1 ==========
const ready = [];       // 华纬无待办 + 鼎捷无问题 → 可直接调试
const needDingjie = []; // 华纬无待办 + 鼎捷有问题 → 鼎捷推进
const needHuawei = [];  // 华纬有待办 → 华纬配合
const inProgress = [];  // 华纬无待办 + 鼎捷有进展但非无问题

s1.forEach(d => {
  const orig = origMap[d.code];
  const origHasHuaweiIssue = orig && orig.huaweiIssue && orig.huaweiIssue.trim() !== '';

  if (origHasHuaweiIssue) {
    // 原始表中华纬有待办 → 归入需华纬配合
    needHuawei.push({...d, source:'原始表华纬待办'});
  } else {
    // 原始表中华纬无待办 → 华纬无待办
    if (!d.dingjieIssue && !d.resolution) {
      ready.push(d);
    } else if (d.resolution && d.resolution !== '未完成') {
      inProgress.push(d);
    } else {
      needDingjie.push(d);
    }
  }
});

// ========== 读取9月11日进展数据 ==========
const wb911 = XLSX.readFile('delivery/inbox/9月11日三厂数采整体状况.xlsx');
const raw911 = XLSX.utils.sheet_to_json(wb911.Sheets['三厂小簧车间数采'], {header:1, defval:''});
const progressData = [];
for(let i=5; i<=28; i++){
  const r = raw911[i];
  if(!r || !r[2]) continue;
  if(r[2]==='需事业部提供支持的设备'||r[2]==='鼎捷方可直接实施设备') continue;
  progressData.push({
    设备类型: r[2]||'', 数量: Number(r[3])||0, 待办: r[4]||'',
    负责人: r[5]||'', 原定完成时间: r[6]||'', 数采状态: r[7]||'',
    沟通进展: r[8]||'', 前置条件: r[9]||'', 预估所需时间: r[10]||''
  });
}

// ========== 创建工作簿 ==========
const wb = XLSX.utils.book_new();

// ---- Sheet 1: 整体概况 ----
const overviewData = [
  ['华纬三厂小簧数采项目 — 整体追踪汇报 v3（纠偏版）', '', '', '', '', ''],
  ['汇报日期', '2026-09-15', '', '数据来源', '樊正毅管控表(9/14) + 9月11日整体状况 + 原始调研表纠偏', ''],
  ['', '', '', '', '', ''],
  ['区块定义（用户确认）', '', '', '', '', ''],
  ['区块', '编号', '定义', '设备数', '占比', '说明'],
  ['一、已提供+通电', 'S1', '厂商已给点位 + 天枢已装好通电', s1.length, (s1.length/106*100).toFixed(1)+'%', '理论可调试'],
  ['二、已提供+未安装', 'S2', '厂商已给点位，但天枢没装上', s2.length, (s2.length/106*100).toFixed(1)+'%', '硬件阻塞'],
  ['三、未提供+通电', 'S3', '天枢已装好通电，厂商没给点位', s3.length, (s3.length/106*100).toFixed(1)+'%', '信息阻塞（最大瓶颈）'],
  ['四、未提供+未安装', 'S4', '厂商没给点位 + 天枢没装', s4.length, (s4.length/106*100).toFixed(1)+'%', '双重阻塞'],
  ['合计', '', '', 106, '100%', ''],
  ['', '', '', '', '', ''],
  ['S1纠偏细分（以原始调研表col30华纬待解决问题为准）', '', '', '', '', ''],
  ['细分状态', '数量', '能否调试', '说明', '建议行动', ''],
  ['✅ 可直接调试（华纬无待办+鼎捷无问题）', ready.length, '可以', '华纬无待办事项，鼎捷可正常推进', '立即安排鼎捷进场调试', ''],
  ['🔶 需鼎捷推进（华纬无待办+鼎捷有问题）', needDingjie.length, '不可以', '华纬无待办，但鼎捷侧注册配置未完成', '催促鼎捷完成注册配置', ''],
  ['🟡 进行中（华纬无待办+鼎捷有进展）', inProgress.length, '待跟进', '华纬无待办，鼎捷侧有进展但未完成', '跟进鼎捷进展', ''],
  ['⚠️ 需华纬配合（原始表华纬有待办）', needHuawei.length, '不可以', '华纬侧有待解决问题需先解决', '甲方/设备厂家/华纬协调', ''],
  ['', '', '', '', '', ''],
  ['关键阻塞点（Top 5）', '', '', '', '', ''],
  ['1. '+s3.length+'台点位未提供（S3全部）', '', '最大瓶颈，需甲方统一发函催厂商', '', '', ''],
  ['2. '+needDingjie.length+'台鼎捷注册配置未完成', '', '端面磨床系列是单类型最大阻塞', '', '', ''],
  ['3. '+needHuawei.length+'台山纬侧有待办事项', '', '协议/IP/硬件/数据库问题', '', '', ''],
  ['4. '+s4.length+'台未安装+未提供点位', '', '需采购IO采集盒+联系厂家', '', '', ''],
  ['5. '+s2.length+'台已提供但未安装', '', '柜门挡住无法安装', '', '', ''],
];
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(overviewData), '整体概况');

// ---- Sheet 2: 可直接调试设备明细 ----
const sheet2Rows = [['可直接调试设备明细（共'+ready.length+'台）—— 华纬无待办+鼎捷无问题，可立即安排调试','',,,,]];
sheet2Rows.push(['序号','设备名称','设备编号','品牌/厂家','采集方式','说明']);
ready.forEach(d=>sheet2Rows.push([d.seq, d.name, d.code, d.brand, d.method, '华纬无待办事项，鼎捷可正常推进，可立即安排调试']));
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet2Rows), '可直接调试设备');

// ---- Sheet 3: 需鼎捷推进设备明细 ----
const sheet3Rows = [['需鼎捷推进设备明细（共'+needDingjie.length+'台）—— 华纬无待办事项，鼎捷侧需完成注册配置','',,,,,,]];
sheet3Rows.push(['序号','设备名称','设备编号','品牌/厂家','采集方式','鼎捷待解决问题','解决情况','备注']);
needDingjie.forEach(d=>sheet3Rows.push([d.seq, d.name, d.code, d.brand, d.method, d.dingjieIssue||'-', d.resolution||'-', d.remark]));
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet3Rows), '需鼎捷推进设备');

// ---- Sheet 4: 进行中设备明细 ----
const sheet4Rows = [['进行中设备明细（共'+inProgress.length+'台）—— 华纬无待办+鼎捷有进展但未完成','',,,,,,]];
sheet4Rows.push(['序号','设备名称','设备编号','品牌/厂家','采集方式','鼎捷待解决问题','解决情况','备注']);
inProgress.forEach(d=>sheet4Rows.push([d.seq, d.name, d.code, d.brand, d.method, d.dingjieIssue||'-', d.resolution, d.remark]));
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet4Rows), '进行中设备');

// ---- Sheet 5: 需华纬配合设备明细 ----
const sheet5Rows = [['需华纬配合设备明细（共'+needHuawei.length+'台）—— 原始调研表华纬有待办事项，需先解决才能调试','',,,,,,,]];
sheet5Rows.push(['序号','设备名称','设备编号','品牌/厂家','采集方式','华纬待解决问题','解决情况','备注']);
needHuawei.forEach(d=>sheet5Rows.push([d.seq, d.name, d.code, d.brand, d.method, d.huaweiIssue, d.resolution||'-', d.remark]));
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet5Rows), '需华纬配合设备');

// ---- Sheet 6: S1完整设备清单（标注纠偏结果）----
const sheet6Rows = [['S1完整设备清单（共'+s1.length+'台：已提供+通电）—— 标注纠偏后分类','',,,,,,,,,'']];
sheet6Rows.push(['序号','设备名称','设备编号','品牌/厂家','采集方式','华纬问题','鼎捷问题','解决情况','纠偏分类','是否可调试','纠偏依据']);
s1.forEach(d => {
  const orig = origMap[d.code];
  const origHasHuaweiIssue = orig && orig.huaweiIssue && orig.huaweiIssue.trim() !== '';
  let category = '', canDebug = '', reason = '';
  if (origHasHuaweiIssue) {
    category = '需华纬配合'; canDebug = '❌否'; reason = '原始表华纬待办不为空';
  } else if (!d.dingjieIssue && !d.resolution) {
    category = '可直接调试'; canDebug = '✅是'; reason = '原始表华纬待办为空+鼎捷无问题';
  } else if (d.resolution && d.resolution !== '未完成') {
    category = '进行中'; canDebug = '🟡待跟进'; reason = '原始表华纬待办为空+鼎捷有进展';
  } else {
    category = '需鼎捷推进'; canDebug = '❌否'; reason = '原始表华纬待办为空+鼎捷有问题';
  }
  sheet6Rows.push([d.seq, d.name, d.code, d.brand, d.method, d.huaweiIssue||'无', d.dingjieIssue||'无', d.resolution||'-', category, canDebug, reason]);
});
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet6Rows), 'S1完整设备清单');

// ---- Sheet 7: 点位未提供设备明细（S3，43台）----
const sheet7Rows = [['点位未提供设备明细（共'+s3.length+'台，已通电）—— 天枢已装好通电，但厂商未提供商点位地址和接口信息','',,,,,,,]];
sheet7Rows.push(['序号','设备名称','设备编号','品牌/厂家','采集方式','数采状态','华纬待解决问题（点位未提供原因）','解决进展']);
s3.forEach(d=>sheet7Rows.push([d.seq, d.name, d.code, d.brand, d.method, d.status||'通电', d.huaweiIssue, d.resolution||'-']));
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet7Rows), '点位未提供设备明细(S3)');

// ---- Sheet 8: 未安装设备明细（S2+S4，共26台）----
const uninstallAll = [...s2, ...s4];
const sheet8Rows = [['未安装设备明细（共'+uninstallAll.length+'台）—— 尚未安装天枢控制器','',,,,,,,]];
sheet8Rows.push(['序号','设备名称','设备编号','品牌/厂家','采集方式','数采状态','华纬待解决问题','备注']);
uninstallAll.forEach(d=>sheet8Rows.push([d.seq, d.name, d.code, d.brand, d.method, d.status, d.huaweiIssue, d.remark]));
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet8Rows), '未安装设备明细');

// ---- Sheet 9: 9月7-11日沟通进展汇总 ----
const sheet9Rows = [['9月7日-9月11日沟通进展汇总（来自9月11日整体状况表）','',,,,,,,,'']];
sheet9Rows.push(['设备类型','数量','待办事项','负责人','原定完成时间','数采状态','沟通进展','前置条件','预估时间']);
progressData.forEach(d=>sheet9Rows.push([d.设备类型, d.数量, d.待办, d.负责人, d.原定完成时间, d.数采状态, d.沟通进展, d.前置条件, d.预估所需时间]));
sheet9Rows.push(['','','需事业部支持设备小计',86,'','','','','']);
sheet9Rows.push(['','','鼎捷可直接实施设备小计',20,'','','','','']);
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet9Rows), '9月7-11日沟通进展');

// ---- Sheet 10: 按品牌统计（S1纠偏后）----
const brandStats = {};
s1.forEach(d => {
  const orig = origMap[d.code];
  const origHasHuaweiIssue = orig && orig.huaweiIssue && orig.huaweiIssue.trim() !== '';
  const b = d.brand||'未知';
  if(!brandStats[b]) brandStats[b]={total:0, huaweiIssue:0, dingjieIssue:0, ready:0, inProgress:0};
  brandStats[b].total++;
  if (origHasHuaweiIssue) brandStats[b].huaweiIssue++;
  if (d.dingjieIssue) brandStats[b].dingjieIssue++;
  if (!origHasHuaweiIssue && !d.dingjieIssue && !d.resolution) brandStats[b].ready++;
  if (!origHasHuaweiIssue && d.resolution && d.resolution !== '未完成') brandStats[b].inProgress++;
});
const sheet10Rows = [['按品牌统计（S1纠偏后：共'+s1.length+'台）','',,,,]];
sheet10Rows.push(['品牌/厂家','总设备数','华纬待办数','鼎捷问题数','可直接调试','进行中']);
for(const [k,v] of Object.entries(brandStats).sort((a,b)=>b[1].total-a[1].total)){
  sheet10Rows.push([k, v.total, v.huaweiIssue, v.dingjieIssue, v.ready, v.inProgress]);
}
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet10Rows), '按品牌统计');

// ---- Sheet 11: 全量设备明细（106台）----
const allDevices = [...s1, ...s2, ...s3, ...s4];
const sheet11Rows = [['全量设备明细（106台）—— 含所有区块及纠偏分类','',,,,,,,,]];
sheet11Rows.push(['区块','序号','设备名称','设备编号','品牌/厂家','采集方式','数采状态','点位收集','华纬待解决问题','鼎捷待解决问题','解决情况','备注']);
allDevices.forEach(d=>{
  let block = '';
  if(s1.includes(d)) block = 'S1(已提供+通电)';
  else if(s2.includes(d)) block = 'S2(已提供+未安装)';
  else if(s3.includes(d)) block = 'S3(未提供+通电)';
  else block = 'S4(未提供+未安装)';
  sheet11Rows.push([block, d.seq, d.name, d.code, d.brand, d.method, d.status||'', d.pointCollection||'', d.huaweiIssue, d.dingjieIssue, d.resolution, d.remark]);
});
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet11Rows), '全量设备明细');

// ========== 写入文件 ==========
const outPath = path.join('delivery', 'projects', 'hw-spring-mes', 'output', '三厂数采_整体追踪汇报_v3.xlsx');
XLSX.writeFile(wb, outPath);
console.log('Excel v3 generated:', outPath);
console.log('Sheets:', wb.SheetNames);
console.log('');
console.log('=== S1纠偏结果 ===');
console.log('  可直接调试:', ready.length, '台');
console.log('  需鼎捷推进:', needDingjie.length, '台');
console.log('  进行中:', inProgress.length, '台');
console.log('  需华纬配合:', needHuawei.length, '台');
console.log('  合计:', s1.length, '台');
console.log('');
console.log('=== 其他区块 ===');
console.log('  S2(已提供+未安装):', s2.length, '台');
console.log('  S3(未提供+通电):', s3.length, '台');
console.log('  S4(未提供+未安装):', s4.length, '台');
console.log('  总计:', s1.length+s2.length+s3.length+s4.length, '台');
console.log('  进展数据:', progressData.length, '条');
