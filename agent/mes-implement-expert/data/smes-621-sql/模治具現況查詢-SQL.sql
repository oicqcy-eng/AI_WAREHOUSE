/*模治具現況查詢*/
Select
	EAS.AccessoryNo ACCESSORYNO
	,EAS.AccessoryType ACCESSORYTYPE
	,EAT.AccessoryCategory ACCESSORYCATEGORY
	,case 
	 when EAS.ACCESSORYSTATE = 0 then N'在库'
	 when EAS.ACCESSORYSTATE = 1 then N'在线'
	 when EAS.ACCESSORYSTATE = 2 then N'上机'
	 when EAS.ACCESSORYSTATE = 3 then N'维修'
	 when EAS.ACCESSORYSTATE = 4 then N'报废'
	 else N'保养'
	 end as ACCESSORYSTATE
	,EAS.ACCTotalUsedQTY Q26ACCTOTALUSEDQTY
	,EEAS.EquipmentNo Q26EQUIPMENTNO
	,EEAS.StartTime Q26STARTTIME
	,EEAS.UserNo MODULEUSERNO
	,ECAS.CombineACCNo COMBINEACCNO
	,ECAS.CombineACCType COMBINEACCTYPE
	,ECAS.CombineACCCateGory COMBINEACCCATEGORY
	,ECAS.Creator Q26CREATOR
	,ECAS.CreateDate Q26CREATEDATE
	,EAB.Priority Q26PRIORITY
	,EAB.STDNumberCavity STDNUMBERCAVITY
	,EAB.GoodNumberCavity GOODNUMBERCAVITY
From
	tblEMSAccessoryState EAS
	join tblEQPAccessoryBasis EAB on EAS.AccessoryNo=EAB.AccessoryNo and EAS.AccessoryVersion=EAB.AccessoryVersion
	join tblEQPAccessoryType EAT on EAS.AccessoryType=EAT.AccessoryType
	left join tblEMSEQPACCState EEAS on EAS.AccessoryNo=EEAS.AccessoryNo and EAS.AccessoryVersion=EEAS.AccessoryVersion
	left join tblEMSCombineACCState ECAS on EAS.AccessoryNo=ECAS.AccessoryNo
