/*设备生产查询*/
WITH DspSum AS 
( 
	SELECT 
		a.LOTNO,
		a.OPNO,
		a.EQUIPMENTNO,
		SUM (a.QTY) QTY,
		MIN (a.WORKDATE) MINDATE
	FROM TBLWIPDISPATCHSTATE a
	WHERE a.WORKDATE <= GETDATE () AND a.WORKDATE > '1900-1-1'
	GROUP BY a.LOTNO, a.OPNO, a.EQUIPMENTNO
),
EQSum
AS 
(  
	SELECT 
		b.LOTNO,
		b.OPNO,
		a.EQUIPMENTNO,
		SUM (a.InputQty) InputQty,
		SUM (a.OutputQty) OutputQty
	FROM TBLWIPCONT_EQUIPMENT a
	JOIN TBLWIPLOTLOG_REPORT b
	ON a.LOGGROUPSERIAL = b.LOGGROUPSERIAL
	GROUP BY b.LOTNO, b.OPNO, a.EQUIPMENTNO
),
/*查询R、W状态的设备生产批数据*/
EQSTATE
AS 
(
	/*W状态，且下个状态是R*/
	select g.EQUIPMENTNO,a.LOTNO,a.OPNO,G.InputQty - G.OutputQty Qty,a.STATUS  FROM      TBLWIPLOTSTATE  A  
	INNER JOIN TBLWIPCONT_EQUIPMENT  G 
	ON A.LOGGROUPSERIAL = G.LOGGROUPSERIAL  AND G.STATUS = 1
	WHERE  (A.CURQTY > 0) AND (A.STATUS = 2) AND (A.GOSTATUS = 1)
	UNION ALL
 	/* R状态 */
	select 
		c.EQUIPMENTNO,a.LOTNO,a.OPNO,c.InputQty - c.OutputQty Qty,a.STATUS  
	FROM      TBLWIPLOTSTATE  A  
	INNER JOIN  TBLWIPCONT_EQUIPMENT C
	ON A.LOGGROUPSERIAL = C.LOGGROUPSERIAL AND  C.STATUS = 0 
	WHERE   (C.InputQty - C.OutputQty > 0) AND (A.CURQTY > 0) AND (A.STATUS = 1)
)
SELECT a.LOTNO                                                          /*生產批號*/
       ,b.MONo                                                    　　  /*工单编号*/
       ,b.PRODUCTNO                                                      /*產品編號*/
       ,c.PRODUCTNAME                                                    /*產品名稱*/
       ,c.ItemSpec                                                         /*規格*/
       ,CASE a.STATUS WHEN 0 THEN N'0:待進站'
        WHEN 1 THEN N'1:生產中'
        WHEN 2 THEN N'2:暫停'
        WHEN 5 THEN N'5:外包中'
        WHEN 11 THEN N'11:良品線邊倉'
        WHEN 12 THEN N'12:不良品線邊倉'
        WHEN 6 THEN N'6:網狀制程未成套'
        WHEN 9 THEN N'9:檢驗中'
        WHEN 10 THEN N'10:外包部分回貨'
        WHEN 99 THEN N'99:轉庫結批'
    END STATUS /*狀態*/
   ,b.RONO /*訂單編號*/
   ,e.AREANO /*區域編號*/
   ,f.AREANAME /*區域名稱*/
   ,a.OPNO /*作業編號*/
   ,g.OPNAME /*作業名稱*/
   ,ISNULL(h.UNITNO, c.UNITNO) UNITNO/*單位*/
   ,a.Qty /*數量*/
   ,i.EQUIPMENTNO /*設備名稱*/
   ,EquipmentName
   ,CONVERT(CHAR(10), j.MINDATE, 20) MinDisptchDate /*最早排程時間*/
   ,j.QTY SUMQTY/*累積派工量*/
   ,j.QTY - (k.OutputQty) UNDoneQty /*未完成*/
   ,k.OutputQty completeqty/*已完成數量*/
    /*,b.ITEMNO 訂單序號*/
   ,CASE m.EQUIPMENTSTATE
        WHEN
            0 THEN N'0:待料'
        WHEN 1 THEN N'1:生產'
        WHEN 2 THEN N'2:故障'
        WHEN 3 THEN N'3:維修'
        WHEN 4 THEN N'4:保養'
    END EQUIPMENTSTATE   /*設備狀態*/
   ,CONVERT(CHAR(16), m.STARTTIME, 120) STARTTIME    /*狀態起始始時間*/
FROM EQSTATE a  
JOIN TBLWIPLOTBASIS b ON a.LOTNO = b.BASELOTNO
LEFT JOIN TBLPRDPRODUCTBASIS c ON b.PRODUCTNO = c.PRODUCTNO    AND b.PRODUCTVERSION = c.PRODUCTVERSION
LEFT JOIN 
(
					SELECT ContainAreaNo AREANO, ObjectNo EQUIPMENTNO
                    FROM tblSMDAreaRelation SAR
                    JOIN tblSMDAreaBasis SAB ON SAR.ContainAreaNo = SAB.AreaNo
                    WHERE SAR.ObjectType = 2 AND SAB.AreaClass = 0 AND SAB.AREATYPE <> 1
                    UNION
                    SELECT SAR.ContainAreaNo AREANO, EGD.EQUIPMENTNO
                    FROM tblSMDAreaRelation SAR
                    JOIN tblSMDAreaBasis SAB ON SAR.ContainAreaNo = SAB.AreaNo
                    JOIN tblEQPGroupDetail EGD ON SAR.ObjectNo = EGD.EquipmentGroup
                    WHERE SAR.ObjectType = 4 AND SAB.AreaClass = 0 AND SAB.AREATYPE = 0
                    UNION
                    SELECT SAB.AreaNo AREANO, SAB.AreaNo EQUIPMENTNO
                    FROM tblSMDAreaRelation SAR
                    JOIN tblSMDAreaBasis SAB ON SAR.Objectno = SAB.AreaNo
                    WHERE SAB.AreaClass = 0 AND SAB.AREATYPE = 1 AND SAR.ObjectType = 0
)
e ON a.EQUIPMENTNO = e.EQUIPMENTNO
LEFT JOIN TBLSMDAREABASIS f    ON e.AREANO = f.AREANO
LEFT JOIN TBLOPBASIS g ON a.OPNO = g.OPNO
LEFT JOIN tblPRDOPUnitConversion h ON b.PRODUCTNO = h.PRODUCTNO    AND b.PRODUCTVERSION = h.PRODUCTVERSION    AND b.PRODUCTNO = h.PROCESSNO AND b.PRODUCTVERSION = h.PROCESSVERSION AND a.OPNO = h.OPNO
LEFT JOIN TBLEQPEQUIPMENTBASIS i ON a.EQUIPMENTNO = i.EQUIPMENTNO
LEFT JOIN DspSum j ON a.LOTNO = j.LOTNO AND a.EQUIPMENTNO = j.EQUIPMENTNO AND a.OPNO = j.OPNO
LEFT JOIN EQSum k ON a.LOTNO = k.LOTNO AND a.EQUIPMENTNO = k.EQUIPMENTNO AND a.OPNO = k.OPNO
LEFT JOIN TBLEMSEQUIPMENTSTATE m ON a.EQUIPMENTNO = m.EQUIPMENTNO
  