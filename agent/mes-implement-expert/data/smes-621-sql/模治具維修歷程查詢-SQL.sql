Select
    a.AccessoryNo,
	a.ACCSerialNo,
    a.AccessoryVersion,
    a.Repairer,
    a.RepairTime,
    a.CreateDate,
    a.Description,
    b.AccessoryType,
    b.AccessoryCategory,
    b.STDNumberCavity,
    b.GoodNumberCavity,
    c.PLANREPAIRFINISHDATE,
	  c.SUBCONTRACTORNO,
	  c.PLANREPAIRER,
	  c.EXPECTREPAIRFINISHDATE
From
    tblEMSACCLog_Repair a
    left join TBLEMSACCESSORYSTATE c on c.AccessoryNo=a.AccessoryNo
    left join tblEQPAccessoryBasis b on a.AccessoryNo=b.AccessoryNo and a.AccessoryVersion=b.AccessoryVersion 