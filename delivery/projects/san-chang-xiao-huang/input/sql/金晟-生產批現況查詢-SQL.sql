/*金晟-生產批現況查詢*--金晟是华纬科技股份有限公司下面的一个厂，主要产品是稳定杆*/

SELECT *
FROM (
    SELECT ISNULL(AR.AREANO, 'N/A') AS AREANO
          ,ISNULL(AR.AREANAME, 'N/A') AS AREANAME
          ,ISNULL(A.EQUIPMENTNO, 'N/A') AS EQUIPMENTNO
          ,CASE
               WHEN EQP.EquipmentName IS NULL OR EQP.EquipmentName = '' THEN 'N/A'
               ELSE EQP.EquipmentName
           END AS EQUIPMENTNAME
          ,A.LOTNO
          ,B.MONO
          ,A.OPNO
          ,C.OPNAME
          ,CASE A.STATUS
               WHEN 0 THEN N'0:待進站'
               WHEN 1 THEN N'1:生產中'
               WHEN 2 THEN N'2:暫停'
               WHEN 5 THEN N'5:外包中'
               WHEN 11 THEN N'11:良品線邊倉'
               WHEN 12 THEN N'12:不良品線邊倉'
               WHEN 6 THEN N'6:網狀製程未成套'
               WHEN 9 THEN N'9:檢驗中'
               WHEN 10 THEN N'10:外包部分回貨'
               WHEN 20 THEN N'20:外包指定結案'
               WHEN 99 THEN N'99:轉庫結批'
           END AS STATUS
          ,B.RONO
          ,B.PRODUCTNO
          ,E.PRODUCTNAME
          ,E.GraphNo
          ,E.ItemSpec
          ,OE.Description AS MODescription
          ,A.CURQTY
           - CASE A.STATUS
                 WHEN 11 THEN (
                     SELECT ISNULL(SUM(T.QTY), 0)
                     FROM tblINVFGDInDetail T
                     WHERE T.LOTNO = A.LOTNO
                       AND ISNULL(T.OPNO, A.OPNO) = A.OPNO
                 )
                 WHEN 12 THEN (
                     SELECT ISNULL(SUM(T.scrapQTY), 0)
                     FROM TBLINVSCRINDETAIL T
                     WHERE T.LOTNO = A.LOTNO
                       AND T.OPNO = A.OPNO
                 )
                 ELSE 0
             END AS CURQTY
          ,ISNULL(DSP.DSPEDQTY, 0) AS DispatchQty
          ,CASE WHEN A.EQUIPMENTNO = 'N/A' THEN 0 ELSE ISNULL(INOUT.INQTY, 0) END AS EQINQTY
          ,CASE WHEN A.EQUIPMENTNO = 'N/A' THEN 0 ELSE ISNULL(INOUT.INQTY, 0) - ISNULL(INOUT.OUTQTY, 0) END AS UNDoneQty
          ,CASE WHEN A.EQUIPMENTNO = 'N/A' THEN 0 ELSE ISNULL(INOUT.OUTQTY, 0) - ISNULL(WAITOUT.WAITQTY, 0) END AS COMPLETEQty
          ,CONVERT(CHAR(10), DSP.MINDATE, 20) AS MinDisptchDate
          ,CONVERT(CHAR(10), DSP.MAXDATE, 20) AS MaxDisptchDate
          ,CONVERT(CHAR(10), B.PLANSTARTDATE, 20) AS PLANSTARTDATE
          ,CONVERT(CHAR(10), B.PLANFINISHDATE, 20) AS PLANFINISHDATE
          ,A.CURUNITNO
          ,B.ITEMNO
          ,B.CUSTOMERNO
          ,CUS.CUSTOMERNAME
          ,B.PRODUCTVERSION
          ,A.PROCESSNO
          ,A.PROCESSVERSION
    FROM v_area_lot A
         JOIN tblWIPLotBasis B
             ON A.BaseLotNo = B.BaseLotNo
         LEFT JOIN tblOEMOBasis OE
             ON OE.MONO = B.MONO
         LEFT JOIN tblOPBasis C
             ON A.OPNo = C.OPNo
         LEFT JOIN tblPRSProcessBasis D
             ON A.ProcessNo = D.ProcessNo
            AND A.ProcessVersion = D.ProcessVersion
         INNER JOIN TBLPRDPRODUCTBASIS E
             ON B.ProductNo = E.PRODUCTNO
            AND B.ProductVersion = E.ProductVersion
         LEFT JOIN TBLENTCUSTOMERBASIS CUS
             ON B.CUSTOMERNO = CUS.CUSTOMERNO
         LEFT JOIN (
             SELECT A.LOTNO
                   ,A.OPNO
                   ,SUM(CASE WHEN A.EQUIPMENTNO <> 'N/A' THEN A.QTY ELSE 0 END) AS DSPEDQTY
                   ,SUM(CASE WHEN A.EQUIPMENTNO = 'N/A' THEN A.QTY ELSE 0 END) AS REMAINDQTY
                   ,MIN(CASE WHEN A.EQUIPMENTNO <> 'N/A' THEN A.WORKDATE ELSE NULL END) AS MINDATE
                   ,MAX(CASE WHEN A.EQUIPMENTNO <> 'N/A' THEN A.WORKDATE ELSE NULL END) AS MAXDATE
             FROM TBLWIPDISPATCHSTATE A
             GROUP BY A.LOTNO, A.OPNO
         ) DSP
             ON A.LOTNO = DSP.LOTNO
            AND A.OPNO = DSP.OPNO
         LEFT JOIN (
             SELECT M.LOTNO
                   ,M.OPNO
                   ,N.EQUIPMENTNO
                   ,SUM(N.INPUTQTY) AS INQTY
                   ,SUM(N.OutputQty) AS OUTQTY
             FROM TBLWIPLOTLOG_REPORT M
             INNER JOIN TBLWIPCONT_EQUIPMENT N
                 ON M.LOGGROUPSERIAL = N.LOGGROUPSERIAL
             GROUP BY M.LOTNO, M.OPNO, N.EQUIPMENTNO
         ) INOUT
             ON A.LOTNO = INOUT.LOTNO
            AND A.OPNO = INOUT.OPNO
            AND A.EQUIPMENTNO = INOUT.EQUIPMENTNO
         LEFT JOIN (
             SELECT SUM(A.RELEASEQTY) AS WAITQTY
                   ,A.LOTNO
                   ,A.OPNO
             FROM TBLWIPWAITBASIS A
             JOIN TBLWIPWAITLOTDISPOSITION B
                 ON A.WAITNO = B.WAITNO
             WHERE A.STATUS = 21
               AND B.LOTDISPTYPE IN (3, 7)
             GROUP BY A.LOTNO, A.OPNO
         ) WAITOUT
             ON WAITOUT.LOTNO = A.LOTNO
            AND WAITOUT.OPNO = A.OPNO
         LEFT JOIN TBLSMDAREABASIS AR
             ON AR.AREANO = A.AREANO
         LEFT JOIN TBLPRDPRODUCTPROCESS PR
             ON B.PRODUCTNO = PR.PRODUCTNO
            AND A.PROCESSNO = PR.PROCESSNO
            AND B.PRODUCTVERSION = PR.PRODUCTVERSION
         LEFT JOIN TBLEQPEQUIPMENTBASIS EQP
             ON EQP.EQUIPMENTNO = A.EQUIPMENTNO
    WHERE A.CURQTY
          - CASE A.STATUS
                WHEN 11 THEN (
                    SELECT ISNULL(SUM(T.QTY), 0)
                    FROM tblINVFGDInDetail T
                    WHERE T.LOTNO = A.LOTNO
                      AND ISNULL(T.OPNO, A.OPNO) = A.OPNO
                )
                WHEN 12 THEN (
                    SELECT ISNULL(SUM(T.scrapQTY), 0)
                    FROM TBLINVSCRINDETAIL T
                    WHERE T.LOTNO = A.LOTNO
                      AND T.OPNO = A.OPNO
                )
                ELSE 0
            END > 0
      AND (
            CASE
                WHEN A.STATUS = 11 THEN (
                    SELECT DISTINCT 1
                    FROM tblINVWIPInventory_SEMI
                    WHERE LOTNO = A.LOTNO
                )
                ELSE 1
            END
          ) = 1
      AND EXISTS (
            SELECT 1
            FROM TBLPRDPRODUCTPROCESS PP
            INNER JOIN TBLPRSPROCESSBASIS PB
                ON PP.PROCESSNO = PB.PROCESSNO
            WHERE PP.PRODUCTNO = B.PRODUCTNO
              AND PP.PRODUCTVERSION = B.PRODUCTVERSION
              AND PB.PROCESSTYPE = N'金晟流程'
              AND PB.CURVERSION = '1'
      )
) A;
