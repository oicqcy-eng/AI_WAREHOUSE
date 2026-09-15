#!/usr/bin/env node
/**
 * generate-shipment-report-v2.js
 * 三厂数采整体追踪汇报 - 修正版
 * 区块定义（用户确认）：
 *   一、已提供+通电：厂商已给点位 + 天枢已装好通电 = 理论可调试
 *   二、已提供+未安装：厂商已给点位，但天枢还没装上 = 硬件阻塞
 *   三、未提供+通电：天枢已装好通电，但厂商没给点位 = 信息阻塞
 *   四、未提供+未安装：厂商没给点位 + 天枢没装 = 双重阻塞
 */
'use strict';
const XLSX = require('../agent/mes-report-agent/node_modules/xlsx');
const path = require('path');

// ========== 读取管控表 ==========
const wb_ctrl = XLSX.readFile('delivery/inbox/华纬三厂小簧数采推进事项管控表_确认版(1)-樊正毅9月14日更新版.xlsx');
const ws_ctrl = wb_ctrl.Sheets['数采推进事项管控表'];
const raw_ctrl = XLSX.utils.sheet_to_json(ws_ctrl, {header:1, defval:''});

function extractBlock(startIdx, endIdx) {
  const arr = [];
  for(let i=startIdx; i<endIdx; i++){
    const r = raw_ctrl[i];
    if(!r) continue;
    const s = String(r[0]);
    if(s.match(/^\d+$/) && r[1] && r[1]!=='甲方设备负责人' && r[1]!=='鼎捷' && r[5]) {
      arr.push({
        seq: Number(r[0]), name: r[1]||'', code: r[2]||'', brand: r[3]||'',
        method: r[4]||'', status: r[5]||'', pointCollection: r[6]||'',
        huaweiIssue: r[7]||'', dingjieIssue: r[8]||'',
        resolution: r[9]||'', remark: r[10]||''
      });
    }
  }
  return arr;
}

const s1 = extractBlock(5, 44);   // 一、已提供+通电 37台
const s2 = extractBlock(46, 48);  // 二、已提供+未安装 1台
const s3 = extractBlock(50, 96);  // 三、未提供+通电 43台
const s4 = extractBlock(98, 158); // 四、未提供+未安装 25台

// ========== 读取9月11日进展数据 ==========
const wb911 = XLSX.readFile('delivery/inbox/9月11日三厂数采整体状况.xlsx');
const ws911 = wb911.Sheets['三厂小簧车间数采'];
const raw911 = XLSX.utils.sheet_to_json(ws911, {header:1, defval:''});
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

// ========== 工作簿 ==========
const wb = XLSX.utils.book_new();

// ---- Sheet 1: 整体概况 ----
const overviewData = [
  ['华纬三厂小簧数采项目 — 整体追踪汇报', '', '', '', '', ''],
  ['汇报日期', '2026-09-15', '', '数据来源', '樊正毅管控表(9/14) + 9月11日整体状况', ''],
  ['', '', '', '', '', ''],
  ['区块定义（用户确认）', '', '', '', '', ''],
  ['区块', '编号', '定义', '设备数', '占比', '说明'],
  ['一、已提供+通电', 'S1', '厂商已给点位 + 天枢已装好通电', 37, '34.9%', '理论可调试（需排除遗留问题）'],
  ['二、已提供+未安装', 'S2', '厂商已给点位，但天枢没装上', 1, '0.9%', '硬件阻塞，先安装天枢'],
  ['三、未提供+通电', 'S3', '天枢已装好通电，厂商没给点位', 43, '40.5%', '信息阻塞，需甲方催厂商'],
  ['四、未提供+未安装', 'S4', '厂商没给点位 + 天枢没装', 25, '23.6%', '双重阻塞，最远端'],
  ['合计', '', '', 106, '100%', ''],
  ['', '', '', '', '', ''],
  ['S1细分（37台中）', '', '', '', '', ''],
  ['细分状态', '数量', '能否调试', '主要阻塞原因', '建议负责人', ''],
  ['✅ 无遗留问题，可直接调试', 4, '可以', '无遗留问题，鼎捷可立即进场', '鼎捷', ''],
  ['⚠️ 华纬侧有待解决问题', 20, '不可以', '协议/IP/硬件/数据库问题', '甲方/设备厂家/华纬', ''],
  ['🔶 鼎捷侧有待解决问题', 13, '不可以', '注册配置未完成', '鼎捷', ''],
  ['', '', '', '', '', ''],
  ['关键阻塞点', '', '', '', '', ''],
  ['1. 43台点位未提供（S3全部+S4大部分）', '', '最大瓶颈，需甲方统一发函', '', '', ''],
  ['2. 13台面端磨床注册配置未完成', '', '鼎捷侧单类型最大阻塞', '', '', ''],
  ['3. 4台海炉需增加采集盒', '', '已提交IT采购审批中', '', '', ''],
  ['4. 3台柜门/安装位置问题', '', '需现场整改', '', '', ''],
  ['', '', '', '', '', ''],
  ['待办事项汇总', '', '', '', '', ''],
  ['序号', '待办事项', '涉及设备数', '责任方', '状态', ''],
  [1, '提供设备数据点位地址表', 69, '设备厂家/客户', '待提供', ''],
  [2, '完成采集盒注册配置', 20, '华纬', '进行中', ''],
  [3, '鼎捷侧完成天枢主体安装配置', 6, '鼎捷', '待处理', ''],
  [4, '加装DIO模块进行IO采集', 22, '华纬/供应商', '待采购安装', ''],
  [5, '开放协议/IP地址/端口号', 35, '设备厂家/客户', '待配合', ''],
  [6, '解决设备柜门打不开问题', 3, '华纬/设备厂家', '待整改', ''],
  [7, '修复损坏的串口线', 1, '设备维修人员', '待整改', ''],
];
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(overviewData), '整体概况');

// ---- Sheet 2: 可直接调试设备明细（S1中无遗留问题，4台） ----
const readyDevices = s1.filter(d => !d.huaweiIssue && !d.dingjieIssue);
const sheet2Rows = [['可直接调试设备明细（共'+readyDevices.length+'台）—— 无遗留问题，鼎捷可立即进场调试','',,,,]];
sheet2Rows.push(['序号','设备名称','设备编号','品牌/厂家','采集方式','说明']);
readyDevices.forEach(d=>sheet2Rows.push([d.seq, d.name, d.code, d.brand, d.method, '可立即安排鼎捷进场调试']));
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet2Rows), '可直接调试设备');

// ---- Sheet 3: 需华纬配合设备明细（S1中有华纬问题的20台）----
const needHuawei = s1.filter(d => d.huaweiIssue);
const sheet3Rows = [['需华纬配合设备明细（共'+needHuawei.length+'台）—— 华纬侧有待解决问题，需先解决后才能调试','',,,,,,,]];
sheet3Rows.push(['序号','设备名称','设备编号','品牌/厂家','采集方式','华纬待解决问题','解决情况','备注']);
needHuawei.forEach(d=>sheet3Rows.push([d.seq, d.name, d.code, d.brand, d.method, d.huaweiIssue, d.resolution||'-', d.remark]));
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet3Rows), '需华纬配合设备');

// ---- Sheet 4: 需鼎捷推进设备明细（S1中有鼎捷问题的13台）----
const needDingjie = s1.filter(d => d.dingjieIssue);
const sheet4Rows = [['需鼎捷推进设备明细（共'+needDingjie.length+'台）—— 华纬侧无问题，鼎捷侧注册配置未完成','',,,,,,]];
sheet4Rows.push(['序号','设备名称','设备编号','品牌/厂家','采集方式','鼎捷待解决问题','解决情况','备注']);
needDingjie.forEach(d=>sheet4Rows.push([d.seq, d.name, d.code, d.brand, d.method, d.dingjieIssue, d.resolution||'-', d.remark]));
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet4Rows), '需鼎捷推进设备');

// ---- Sheet 5: S1设备完整清单（37台，标注哪些可调/不可调） ----
const sheet5Rows = [['S1完整设备清单（共'+s1.length+'台：已提供+通电）','',,,,,,,,]];
sheet5Rows.push(['序号','设备名称','设备编号','品牌/厂家','采集方式','华纬问题','鼎捷问题','解决情况','是否可调试']);
s1.forEach(d=>{
  const canDebug = !d.huaweiIssue && !d.dingjieIssue;
  sheet5Rows.push([d.seq, d.name, d.code, d.brand, d.method,
    d.huaweiIssue||'无', d.dingjieIssue||'无', d.resolution||'-',
    canDebug ? '✅是' : '❌否('+((d.huaweiIssue?'华纬':'')+(d.dingjieIssue?',鼎捷':''))+')']);
});
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet5Rows), 'S1完整设备清单');

// ---- Sheet 6: 点位未提供设备明细（S3，43台）----
const sheet6Rows = [['点位未提供设备明细（共'+s3.length+'台，已通电）—— 天枢已装好通电，但厂商未提供商点位地址和接口信息，甲方需继续联系厂家','',,,,,,,]];
sheet6Rows.push(['序号','设备名称','设备编号','品牌/厂家','采集方式','数采状态','华纬待解决问题（点位未提供原因）','解决进展']);
s3.forEach(d=>sheet6Rows.push([d.seq, d.name, d.code, d.brand, d.method, d.status, d.huaweiIssue, d.resolution||'-']));
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet6Rows), '点位未提供设备明细(S3)');

// ---- Sheet 7: 未安装设备明细（S2+S4，共26台）----
const uninstallAll = [...s2, ...s4];
const sheet7Rows = [['未安装设备明细（共'+uninstallAll.length+'台）—— 尚未安装天枢控制器','',,,,,,,]];
sheet7Rows.push(['序号','设备名称','设备编号','品牌/厂家','采集方式','数采状态','华纬待解决问题','备注']);
uninstallAll.forEach(d=>sheet7Rows.push([d.seq, d.name, d.code, d.brand, d.method, d.status, d.huaweiIssue, d.remark]));
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet7Rows), '未安装设备明细');

// ---- Sheet 8: 9月7-11日沟通进展汇总 ----
const sheet8Rows = [['9月7日-9月11日沟通进展汇总（来自9月11日整体状况表）','',,,,,,,,'']];
sheet8Rows.push(['设备类型','数量','待办事项','负责人','原定完成时间','数采状态','沟通进展','前置条件','预估时间']);
progressData.forEach(d=>sheet8Rows.push([d.设备类型, d.数量, d.待办, d.负责人, d.原定完成时间, d.数采状态, d.沟通进展, d.前置条件, d.预估所需时间]));
sheet8Rows.push(['','','需事业部支持设备小计',86,'','','','','']);
sheet8Rows.push(['','','鼎捷可直接实施设备小计',20,'','','','','']);
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet8Rows), '9月7-11日沟通进展');

// ---- Sheet 9: 按品牌统计 ----
const brandStats = {};
s1.forEach(d=>{
  const b = d.brand||'未知';
  if(!brandStats[b]) brandStats[b]={total:0, hwIssue:0, djIssue:0};
  brandStats[b].total++;
  if(d.huaweiIssue) brandStats[b].hwIssue++;
  if(d.dingjieIssue) brandStats[b].djIssue++;
});
const sheet9Rows = [['按品牌统计（S1：已通电+点位已提供设备，共'+s1.length+'台）','',,,]];
sheet9Rows.push(['品牌/厂家','总设备数','华纬侧问题数','鼎捷侧问题数']);
for(const [k,v] of Object.entries(brandStats).sort((a,b)=>b[1].total-a[1].total)){
  sheet9Rows.push([k, v.total, v.hwIssue, v.djIssue]);
}
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet9Rows), '按品牌统计');

// ---- Sheet 10: 全量设备明细（106台）----
const allDevices = [...s1, ...s2, ...s3, ...s4];
const sheet10Rows = [['全量设备明细（106台）—— 含所有区块','',,,,,,,,]];
sheet10Rows.push(['区块','序号','设备名称','设备编号','品牌/厂家','采集方式','数采状态','点位收集','华纬待解决问题','鼎捷待解决问题','解决情况','备注']);
allDevices.forEach(d=>{
  let block = '';
  if(s1.includes(d)) block = 'S1(已提供+通电)';
  else if(s2.includes(d)) block = 'S2(已提供+未安装)';
  else if(s3.includes(d)) block = 'S3(未提供+通电)';
  else block = 'S4(未提供+未安装)';
  sheet10Rows.push([block, d.seq, d.name, d.code, d.brand, d.method, d.status, d.pointCollection, d.huaweiIssue, d.dingjieIssue, d.resolution, d.remark]);
});
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet10Rows), '全量设备明细');

// ========== 写入文件 ==========
const outPath = path.join('delivery', 'projects', 'hw-spring-mes', 'output', '三厂数采_整体追踪汇报_v2.xlsx');
XLSX.writeFile(wb, outPath);
console.log('Excel generated:', outPath);
console.log('Sheets:', wb.SheetNames);
console.log('S1:', s1.length, '| S2:', s2.length, '| S3:', s3.length, '| S4:', s4.length);
console.log('Ready:', readyDevices.length, '| NeedHuawei:', needHuawei.length, '| NeedDingjie:', needDingjie.length);
console.log('Progress rows:', progressData.length);
