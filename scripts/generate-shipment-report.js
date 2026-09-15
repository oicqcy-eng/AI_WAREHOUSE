#!/usr/bin/env node
/**
 * generate-shipment-report.js
 * 生成三厂数采整体追踪汇报 Excel
 */
'use strict';
const XLSX = require('../agent/mes-report-agent/node_modules/xlsx');

// ========== 读取管控表原始数据 ==========
const wb_ctrl = XLSX.readFile('delivery/inbox/华纬三厂小簧数采推进事项管控表_确认版(1)-樊正毅9月14日更新版.xlsx');
const ws_ctrl = wb_ctrl.Sheets['数采推进事项管控表'];
const raw_ctrl = XLSX.utils.sheet_to_json(ws_ctrl, {header:1, defval:''});

function extractDevices(startIdx, endIdx) {
  const arr = [];
  for(let i=startIdx; i<endIdx; i++){
    const r = raw_ctrl[i];
    if(!r) continue;
    const s = String(r[0]);
    if(s.match(/^\d+$/) && r[1] && r[1]!=='甲方设备负责人' && r[1]!=='鼎捷' && r[5]) {
      arr.push({
        seq: r[0], name: r[1]||'', code: r[2]||'', brand: r[3]||'',
        method: r[4]||'', status: r[5]||'', pointCollection: r[6]||'',
        huaweiIssue: r[7]||'', dingjieIssue: r[8]||'',
        resolution: r[9]||'', remark: r[10]||''
      });
    }
  }
  return arr;
}

const s1 = extractDevices(5, 44);   // 已提供+通电 37台
const s2 = extractDevices(46, 48);  // 已提供+未安装 1台
const s3 = extractDevices(50, 96);  // 未提供+通电 43台
const s4 = extractDevices(98, 158); // 未提供+未安装 25台

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

// ========== 创建工作簿 ==========
const wb = XLSX.utils.book_new();

// ---- Sheet 1: 整体概况 ----
const overviewData = [
  ['华纬三厂小簧数采项目 — 整体追踪汇报', '', '', '', '', ''],
  ['汇报日期', '2026-09-15', '', '数据来源', '樊正毅管控表(9/14) + 9月11日整体状况', ''],
  ['', '', '', '', '', ''],
  ['一、项目总览', '', '', '', '', ''],
  ['指标', '数值', '占比', '', '', ''],
  ['总设备数', 106, '100%', '', '', ''],
  ['已安装（盒子通电）', 80, '75.5%', '', '', ''],
  ['未安装', 26, '24.5%', '', '', ''],
  ['', '', '', '', '', ''],
  ['二、已安装设备细分（核心关注）', '', '', '', '', ''],
  ['细分状态', '数量', '能否调试', '主要阻塞原因', '建议负责人', ''],
  ['可直接调试（无遗留问题）', 4, '可以', '无遗留问题，可立即安排', '鼎捷', ''],
  ['需华纬配合才能调试', 13, '不可以', '协议/IP/硬件/数据库问题', '甲方/设备厂家/华纬', ''],
  ['需鼎捷推进注册配置', 16, '不可以', '鼎捷侧注册配置未完成', '鼎捷', ''],
  ['解决进展中/待跟进', 7, '待跟进', '已对接厂家/采购审批中', '华纬IT部门', ''],
  ['', '', '', '', '', ''],
  ['三、未安装设备', '', '', '', '', ''],
  ['细分状态', '数量', '说明', '', '', ''],
  ['点位已提供+未安装', 1, '柜门挡住无法安装', '', '', ''],
  ['点位未提供+未安装', 25, '需采购IO采集盒+联系厂家', '', '', ''],
  ['', '', '', '', '', ''],
  ['四、通电但未安装+点位未提供（最大瓶颈）', '', '', '', '', ''],
  ['细分状态', '数量', '说明', '', '', ''],
  ['点位未提供+已通电', 43, '29台需开放ModbusTCP，10台需确认IO采集', '', '', ''],
  ['', '', '', '', '', ''],
  ['五、关键待办事项汇总', '', '', '', '', ''],
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

// ---- Sheet 2: 可直接调试设备明细 ----
const readyDevices = s1.filter(d => !d.huaweiIssue && !d.dingjieIssue && (!d.resolution || d.resolution===''));
const sheet2Rows = [['可直接调试设备明细（共'+readyDevices.length+'台）','',,,,]];
sheet2Rows.push(['序号','设备名称','设备编号','品牌/厂家','采集方式','说明']);
readyDevices.forEach(d=>sheet2Rows.push([d.seq, d.name, d.code, d.brand, d.method, '无遗留问题，可立即安排鼎捷进场调试']));
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet2Rows), '可直接调试设备');

// ---- Sheet 3: 需华纬配合设备明细 ----
const needHuawei = s1.filter(d => d.huaweiIssue || (d.remark && d.remark.includes('柜门')));
const sheet3Rows = [['需华纬配合设备明细（共'+needHuawei.length+'台）—— 硬件/协议/接口问题，华纬侧需先解决后才能调试','',,,,,,,]];
sheet3Rows.push(['序号','设备名称','设备编号','品牌/厂家','采集方式','华纬待解决问题','解决情况','备注']);
needHuawei.forEach(d=>sheet3Rows.push([d.seq, d.name, d.code, d.brand, d.method, d.huaweiIssue, d.resolution||'-', d.remark]));
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet3Rows), '需华纬配合设备');

// ---- Sheet 4: 需鼎捷推进设备明细 ----
const needDingjie = s1.filter(d => d.dingjieIssue && !d.huaweiIssue);
const sheet4Rows = [['需鼎捷推进设备明细（共'+needDingjie.length+'台）—— 华纬侧无问题，鼎捷侧注册配置未完成','',,,,,,]];
sheet4Rows.push(['序号','设备名称','设备编号','品牌/厂家','采集方式','鼎捷待解决问题','解决情况','备注']);
needDingjie.forEach(d=>sheet4Rows.push([d.seq, d.name, d.code, d.brand, d.method, d.dingjieIssue, d.resolution||'-', d.remark]));
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet4Rows), '需鼎捷推进设备');

// ---- Sheet 5: 点位未提供设备明细（已通电，43台） ----
const sheet5Rows = [['点位未提供设备明细（共'+s3.length+'台，已通电）—— 最大瓶颈，需甲方协调设备厂家开放协议','',,,,,,,]];
sheet5Rows.push(['序号','设备名称','设备编号','品牌/厂家','采集方式','数采状态','华纬待解决问题（点位未提供原因）','解决进展']);
s3.forEach(d=>sheet5Rows.push([d.seq, d.name, d.code, d.brand, d.method, d.status, d.huaweiIssue, d.resolution||'-']));
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet5Rows), '点位未提供设备明细');

// ---- Sheet 6: 未安装设备明细（26台） ----
const uninstallAll = [...s2, ...s4];
const sheet6Rows = [['未安装设备明细（共'+uninstallAll.length+'台）—— 尚未安装天枢控制器','',,,,,,,]];
sheet6Rows.push(['序号','设备名称','设备编号','品牌/厂家','采集方式','数采状态','华纬待解决问题','备注']);
uninstallAll.forEach(d=>sheet6Rows.push([d.seq, d.name, d.code, d.brand, d.method, d.status, d.huaweiIssue, d.remark]));
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet6Rows), '未安装设备明细');

// ---- Sheet 7: 9月7-11日沟通进展汇总 ----
const sheet7Rows = [['9月7日-9月11日沟通进展汇总（来自9月11日整体状况表）','',,,,,,,,'']];
sheet7Rows.push(['设备类型','数量','待办事项','负责人','原定完成时间','数采状态','9月7-11日沟通进展','前置条件','预估完成时间']);
progressData.forEach(d=>sheet7Rows.push([d.设备类型, d.数量, d.待办, d.负责人, d.原定完成时间, d.数采状态, d.沟通进展, d.前置条件, d.预估所需时间]));
sheet7Rows.push(['','','需事业部支持设备小计',86,'','','','','']);
sheet7Rows.push(['','','鼎捷可直接实施设备小计',20,'','','','','']);
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet7Rows), '9月7-11日沟通进展');

// ---- Sheet 8: 按品牌统计 ----
const brandStats = {};
s1.forEach(d=>{
  const b = d.brand||'未知';
  if(!brandStats[b]) brandStats[b]={total:0, hwIssue:0, djIssue:0, ok:0};
  brandStats[b].total++;
  if(d.huaweiIssue) brandStats[b].hwIssue++;
  if(d.dingjieIssue) brandStats[b].djIssue++;
  if(d.resolution && d.resolution!=='未完成') brandStats[b].ok++;
});
const sheet8Rows = [['按品牌统计（S1：已通电+点位已提供设备，共'+s1.length+'台）','',,,,,]];
sheet8Rows.push(['品牌/厂家','总设备数','华纬侧问题数','鼎捷侧问题数','已解决/有进展','说明']);
for(const [k,v] of Object.entries(brandStats).sort((a,b)=>b[1].total-a[1].total)){
  sheet8Rows.push([k, v.total, v.hwIssue, v.djIssue, v.ok]);
}
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet8Rows), '按品牌统计');

// ---- Sheet 9: 全量设备明细（106台） ----
const allDevices = [...s1, ...s2, ...s3, ...s4];
const sheet9Rows = [['全量设备明细（106台）—— 含所有区块','',,,,,,,,]];
sheet9Rows.push(['序号','设备名称','设备编号','品牌/厂家','采集方式','数采状态','点位收集','华纬待解决问题','鼎捷待解决问题','解决情况','备注']);
allDevices.forEach(d=>sheet9Rows.push([d.seq, d.name, d.code, d.brand, d.method, d.status, d.pointCollection, d.huaweiIssue, d.dingjieIssue, d.resolution, d.remark]));
XLSX.utils.book_append_sheet(wb, XLSX.utils.aoa_to_sheet(sheet9Rows), '全量设备明细');

// ========== 写入文件 ==========
XLSX.writeFile(wb, 'delivery/projects/hw-spring-mes/output/三厂数采_整体追踪汇报.xlsx');
console.log('Excel generated: 三厂数采_整体追踪汇报.xlsx');
console.log('Sheets:', wb.SheetNames);
console.log('Total devices in full sheet:', allDevices.length);
console.log('S1(已提供+通电):', s1.length, '| S2(已提供+未安装):', s2.length, '| S3(未提供+通电):', s3.length, '| S4(未提供+未安装):', s4.length);
console.log('Ready to debug:', readyDevices.length, '| Need Huawei:', needHuawei.length, '| Need Dingjie:', needDingjie.length);
console.log('Progress data rows:', progressData.length);
