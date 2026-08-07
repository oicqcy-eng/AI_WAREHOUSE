
/*生产批操作历程*/
select aa.LotNo  --生产批
,isnull(aa.OPNo,'N/A') OPNo --作业站
,aa.DTYPENAME --类型
,case when aa.EQUIPMENTNO is null or aa.EQUIPMENTNO='' then 'N/A'
   else aa.EQUIPMENTNO end EQUIPMENTNO --设备编号
,ISNULL(aa.EquipmentName,'N/A') EquipmentName --设备名称
,aa.EventTime CREATE_TIME --时间
,aa.InputQty qty --数量
,case when aa.UserNo is null or aa.UserNo='' then 'N/A'
   else aa.UserNo end UserNo --人员编号
,ISNULL(aa.USERNAME,'N/A') USERNAME --人员名称
from (
/*1、生产批开立*/
select lot.BASELOTNO LotNo
,'LOTCREATE' OPNO
,LOT.CREATEDATE EventTime
,'N/A' EQUIPMENTNO
,'N/A' EquipmentName
,LOT.CREATOR UserNo
,us.USERNAME USERNAME
,lot.INPUTQTY
,N'[%Module_SYS.LOTCREATE%]' DTYPENAME   --开批
from TBLWIPLOTBASIS lot
left join tblUSRUserBasis us on us.USERNO=lot.CREATOR
/*2、进站报工*/
union all
select b.LotNo
,b.OPNo
,b.EventTime
,b.EQUIPMENTNO
,eq.EquipmentName
,b.UserNo
,us.USERNAME
,b.InputQty
,N'[%Module_SYS.CHECKIN%]'  DTYPENAME --进站
from tblWIPCont_Partialin  b
left join TBLEQPEQUIPMENTBASIS eq on eq.EQUIPMENTNO=b.EQUIPMENTNO
left join tblUSRUserBasis us on us.USERNO=b.UserNo
/*3、出站报工*/
union all
select a.LotNo
,a.OPNo
,a.EventTime
,a.EQUIPMENTNO
,eq.EquipmentName
,a.UserNo
,us.USERNAME
,a.InputQty
,N'[%Module_SYS.CHECKOUT%]' DTYPENAME   --出站
from tblWIPCont_PartialOut a
left join TBLEQPEQUIPMENTBASIS eq on eq.EQUIPMENTNO=a.EQUIPMENTNO
left join tblUSRUserBasis us on us.USERNO=a.UserNo
/*4、设备变更*/
union all
select c.LOTNO
,c.OPNO
,c.MOVEDATE
,c.FROMEQUIPMENTNO EQUIPMENTNO
,eq.EquipmentName
,c.USERNO
,us.USERNAME
,c.MOVEQTY INPUTQTY
,N'[%Module_SYS.EQPCHANGE%]' DTYPENAME  --设备变更
from tblWIPLotEQPChangeLog c
left join TBLEQPEQUIPMENTBASIS eq on eq.EQUIPMENTNO=c.FROMEQUIPMENTNO
left join tblUSRUserBasis us on us.USERNO=c.UserNo
/*5、良品入库*/
union all
select td.LOTNO
,td.OPNo
,tb.CREATEDATE
,'N/A' EQUIPMENTNO
,'N/A' EquipmentName
,tb.CREATOR
,us.USERNAME
,td.QTY INPUTQTY
,N'[%Module_SYS.GOINVENTORY%]' DTYPENAME  --良品入库
from tblINVFGDInDetail td
join tblINVFGDInBasis tb on td.FGDINNO=tb.FGDINNO
left join tblUSRUserBasis us on us.USERNO=tb.CREATOR
/*6、分批作业*/
union all
select fp.FROMLOTNO
,fp.OPNO
,fp.EVENTTIME
,'N/A' EQUIPMENTNO
,'N/A' EquipmentName
,fp.USERNO
,us.USERNAME
,fp.TOLOTQTY
,N'[%Module_SYS.SPLITFROM%]' DTYPENAME   --分批
from tblWIPSplitContent fp
left join tblUSRUserBasis us on us.USERNO=fp.USERNO
/*7、并批作业*/
union all
select bp.FROMLOTNO
,bp.OPNO
,bp.EVENTTIME
,'N/A' EQUIPMENTNO
,'N/A' EquipmentName
,bp.USERNO
,us.USERNAME
,bp.TOLOTQTY
,N'[%Module_SYS.MERGEFROM%]' DTYPENAME --并批
from tblWIPMergeContent bp
left join tblUSRUserBasis us on us.USERNO=bp.USERNO
/*8、外包出货作业*/
union all
select osd.LOTNO
,osb.OPNO
,osb.CREATEDATE
,osb.SUBCONTRACTORNO EQUIPMENTNO
,wb.SUBCONTRACTORNAME EquipmentName
,osb.CREATOR
,us.USERNAME
,osd.INPUTQTY
,N'[%Module_SYS.OSCONFIRM%]' DTYPENAME  --外包出货
from tblWIPOSBasis osb
join tblWIPOSDetail osd on osb.osno=osd.OSNO
left join TBLENTSUBCONTRACTOR wb on wb.SUBCONTRACTORNO=osb.SUBCONTRACTORNO
left join tblUSRUserBasis us on us.USERNO=osb.CREATOR
/*9、外包回货作业*/
union all
select osl.LOTNO
,osb.OPNO
,osl.ReturnDate
,osb.SUBCONTRACTORNO EQUIPMENTNO
,wb.SUBCONTRACTORNAME EquipmentName
,osl.UserNo
,us.USERNAME
,osl.ReturnQty
,N'[%Module_SYS.OSRETURN%]' DTYPENAME --外包回货
from tblWIPOSBasis osb
join tblWIPOSReturnLog osl on osb.OSNO=osl.OSNO
left join TBLENTSUBCONTRACTOR wb on wb.SUBCONTRACTORNO=osb.SUBCONTRACTORNO
left join tblUSRUserBasis us on us.USERNO=osl.UserNo
/*10、生产批暂停*/
union all
select wt.LOTNO
,wt.OPNO
,wt.CREATEDATE
,wt.EQUIPMENTNO
,eq.EquipmentName
,wt.CREATOR
,us.USERNAME
,wt.CREATEQTY
,N'[%Module_SYS.WAITDISPOSITION%]' DTYPENAME   --生产批暂停
from tblWIPWaitBasis wt
left join TBLEQPEQUIPMENTBASIS eq on eq.EQUIPMENTNO=wt.EQUIPMENTNO
left join tblUSRUserBasis us on us.USERNO=wt.CREATOR
/*11、生产批解除暂停*/
union all
select wt.LOTNO
,wt.OPNO
,wtd.CREATEDATE
,wt.EQUIPMENTNO
,eq.EquipmentName
,wtd.CREATOR
,us.USERNAME
,wt.CREATEQTY
,case wtd.lotdisptype when 0 then N'[%Module_SYS.RELEASE-GO%]'   --解除暂停-继续生产
                      when 1 then N'[%Module_SYS.RELEASE-JumpOP%]' --解除暂停-跳站/重工/让步
					  when 2 then N'[%Module_SYS.RELEASE-JumpProcess%]' --解除暂停-跳流程
					  when 3 then N'[%Module_SYS.RELEASE-Inventory%]' --解除暂停-结束生产
					  when 7 then N'[%Module_SYS.RELEASE-ScrapInvebtory%]' --解除暂停-整批报废
  end DTYPENAME
from tblWIPWaitLotDisposition wtd
join tblWIPWaitBasis wt on wt.WAITNO=wtd.WAITNO
left join TBLEQPEQUIPMENTBASIS eq on eq.EQUIPMENTNO=wt.EQUIPMENTNO
left join tblUSRUserBasis us on us.USERNO=wtd.CREATOR
/*12、重工作业*/
union all
select rw.LOTNO
,rw.OpNo
,rw.EVENTTIME
,rw.EquipmentNo
,eq.EquipmentName EquipmentName
,'N/A' UserNo
,'N/A' USERNAME
,lot.INPUTQTY
,N'[%Module_SYS.REWORK%]' DTYPENAME  --重工
from TblWIPReworkReason rw
join TBLWIPLOTBASIS lot on lot.BASELOTNO=rw.REWORKLOTNO
left join TBLEQPEQUIPMENTBASIS eq on eq.EQUIPMENTNO=rw.EQUIPMENTNO
 where rw.LotState in ('0','1')
) aa 