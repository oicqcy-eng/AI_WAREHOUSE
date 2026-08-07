WITH RPT_LotHistory_N
     AS (SELECT C.DTYPE
               ,C.DTYPENAME
               ,ISNULL(C.LOGGROUPSERIAL,N'N/A')  AS LOGGROUPSERIAL
               ,C.LOTNO
               ,C.OPNO
               ,C.INPUTQTY
               ,C.GOODQTY
               ,C.FAILQTY
               ,C.LOSSQTY
               ,C.STARTTIME
               ,C.ENDTIME
               ,C.ERFNO
               ,C.WAITNO
               ,C.DATAKEY
               ,C.PROCESSNO
               ,A.MONO
               ,A.CUSTOMERNO
               ,A.BASELOTNO
               ,A.PRODUCTNO
               ,B.PRODUCTNAME
               ,A.CUSTOMERLOTNO
               ,C.EMPLOYEENO
               ,C.CHECKINTIME
               ,C.CHECKOUTTIME
           FROM TBLWIPLOTBASIS A
               ,TBLPRDPRODUCTBASIS B
               , (SELECT 9 AS DTYPE
                          ,N'一般' AS DTYPENAME
                          ,A.LOGGROUPSERIAL
                          ,A.LOTNO
                          ,A.OPNO
                          ,A.INPUTQTY
                          ,A.GOODQTY
                          ,A.FAILQTY
                          ,A.LOSSQTY
                          ,A.STARTTIME
                          ,A.ENDTIME
                          ,A.BASELOTNO
                          ,NULL AS ERFNO
                          ,NULL AS WAITNO
                          ,NULL AS DATAKEY
                          ,B.PROCESSNO
                          ,NULL AS EMPLOYEENO
                          ,A.MONO
                          ,A.CHECKINTIME
                          ,A.CHECKOUTTIME
                      FROM TBLPRSNODEBASIS B
                           RIGHT OUTER JOIN TBLWIPLOTLOG_REPORT A
                              ON A.NODEID = B.NODEID			
/*#107663，生产批开立的数量改为从tblWIPLotBasis中获取↓↓↓*/			  
							  where a.OPNO<>N'LOTCREATE'
			and a.INPUTQTY>0 /*#114278，过滤掉工单结案时产生的inputqty=0的数据*/
                 UNION 
				 SELECT 9 AS DTYPE
                          ,N'一般' AS DTYPENAME
                          ,A.LOGGROUPSERIAL
                          ,A.LOTNO
                          ,A.OPNO
                          ,c.INPUTQTY
                          ,A.GOODQTY
                          ,A.FAILQTY
                          ,A.LOSSQTY
                          ,A.STARTTIME
                          ,A.ENDTIME
                          ,A.BASELOTNO
                          ,NULL AS ERFNO
                          ,NULL AS WAITNO
                          ,NULL AS DATAKEY
                          ,B.PROCESSNO
                          ,NULL AS EMPLOYEENO
                          ,A.MONO
                          ,A.CHECKINTIME
                          ,A.CHECKOUTTIME
                      FROM TBLPRSNODEBASIS B
                           RIGHT OUTER JOIN TBLWIPLOTLOG_REPORT A ON A.NODEID = B.NODEID
						   join tblWIPLotBasis c on a.LOTNO=c.BASELOTNO
                               where a.OPNO=N'LOTCREATE'
		/*#107663，生产批开立的数量改为从tblWIPLotBasis中获取↑↑↑*/	
                  UNION
                   /* 20231013 modify by zhaosf for M#0147898*/
                  /*SELECT 1 AS DTYPE
                        ,N'ERF' AS DTYPENAME
                        ,A.CONTLOGGROUPSERIAL AS LOGGROUPSERIAL
                        ,A.LOTNO
                        ,A.OPNO
                        ,A.CREATEQTY AS INPUTQTY
                        ,A.RELEASEQTY AS GOODQTY
                        ,NULL
                        ,NULL
                        ,A.CREATEDATE AS STARTTIME
                        ,A.RELEASEDATE AS ENDTIME
                        ,A.BASELOTNO
                        ,A.ERFNO
                        ,NULL
                        ,NULL
                        ,NULL
                        ,A.CREATOR AS EMPLOYEENO
                        ,B.MONO
                        ,B.CHECKINTIME
                        ,B.CHECKOUTTIME
                    FROM TBLWIPERFBASIS A
                         RIGHT OUTER JOIN TBLWIPLOTLOG_REPORT B
                            ON A.CONTLOGGROUPSERIAL = B.LOGGROUPSERIAL
                   WHERE ERFSOURCE = 0
                  UNION*/
                  SELECT 2 AS DTYPE  --Queue Wait
                        ,N'暂停' AS DTYPENAME
                        ,A.CONTLOGGROUPSERIAL AS LOGGROUPSERIAL
                        ,A.LOTNO
                        ,A.OPNO
                        ,A.CREATEQTY AS INPUTQTY
                        ,A.RELEASEQTY AS GOODQTY
                        ,NULL
                        ,NULL
                        ,A.CREATEDATE AS STARTTIME
                        ,A.RELEASEDATE AS ENDTIME
                        ,A.BASELOTNO
                        ,NULL
                        ,A.WAITNO
                        ,NULL
                        ,NULL
                        ,A.CREATOR AS EMPLOYEENO
                        ,LB.MONO
                        ,NULL
                        ,NULL
                    FROM TBLWIPWAITBASIS A
                         JOIN tblWIPLotBasis LB ON LB.BaseLotNo = A.BaseLotNo
				　WHERE A.WAITSOURCE = 0 AND A.WAITTYPE = 5 /*#91339 只可對應3.2之後版本*/
                  UNION
                  SELECT 2 AS DTYPE   --Run Wait
                        ,N'暂停' AS DTYPENAME
                        ,A.CONTLOGGROUPSERIAL AS LOGGROUPSERIAL
                        ,A.LOTNO
                        ,A.OPNO
                        ,A.CREATEQTY AS INPUTQTY
                        ,A.RELEASEQTY AS GOODQTY
                        ,NULL
                        ,NULL
                        ,A.CREATEDATE AS STARTTIME
                        ,A.RELEASEDATE AS ENDTIME
                        ,A.BASELOTNO
                        ,NULL
                        ,A.WAITNO
                        ,NULL
                        ,NULL
                        ,A.CREATOR AS EMPLOYEENO
                        ,B.MONO
                        ,B.CHECKINTIME
                        ,B.CHECKOUTTIME
                    FROM TBLWIPWAITBASIS A
                         RIGHT OUTER JOIN TBLWIPLOTLOG_REPORT B
                            ON /*A.LOTNO=B.LOTNO and A.OPNO=B.OPNO*/
                              A.CONTLOGGROUPSERIAL = B.LOGGROUPSERIAL /*#81806*/
				　WHERE A.WAITSOURCE = 0 AND A.WAITTYPE = 6 /*#91339 只可對應3.2之後版本*/
                  UNION
                  SELECT 3 AS DTYPE
                        ,N'分批(母)' AS DTYPENAME
                        ,NULL
                        ,FROMLOTNO AS LOTNO
                        ,OPNO
                        ,FROMLOTQTY AS INPUTQTY
                        ,NULL
                        ,NULL
                        ,NULL
                        ,EVENTTIME AS STARTTIME
                        ,EVENTTIME AS ENDTIME
                        ,FROMBASELOTNO AS BASELOTNO
                        ,NULL
                        ,NULL
                        ,FROMLOTSERIAL
                        ,NULL
                        ,USERNO AS EMPLOYEENO
                        ,FROMMONO AS MONO
                        ,NULL
                        ,NULL
                    FROM TBLWIPSPLITCONTENT
                  UNION
                  SELECT 4 AS DTYPE
                        ,N'分批(子)' AS DTYPENAME
                        ,NULL
                        ,TOLOTNO AS LOTNO
                        ,OPNO
                        ,TOLOTQTY AS INPUTQTY
                        ,NULL
                        ,NULL
                        ,NULL
                        ,EVENTTIME AS STARTTIME
                        ,EVENTTIME AS ENDTIME
                        ,TOBASELOTNO AS BASELOTNO
                        ,NULL
                        ,NULL
                        ,FROMLOTSERIAL
                        ,NULL
                        ,USERNO AS EMPLOYEENO
                        ,TOMONO AS MONO
                        ,NULL
                        ,NULL
                    FROM TBLWIPSPLITCONTENT
		/*20231121 modify by zhaosf for M#0150392: 穎宸6.0:生產批歷程查詢資料錯誤*/
		WHERE TOLOTQTY > 0
                  UNION
                  SELECT 5 AS DTYPE
                        ,N'并批(母)' AS DTYPENAME
                        ,NULL
                        ,FROMLOTNO AS LOTNO
                        ,OPNO
                        ,FROMLOTQTY AS INPUTQTY
                        ,NULL
                        ,NULL
                        ,NULL
                        ,EVENTTIME AS STARTTIME
                        ,EVENTTIME AS ENDTIME
                        ,FROMBASELOTNO AS BASELOTNO
                        ,NULL
                        ,NULL
                        ,TOLOTSERIAL
                        ,NULL
                        ,USERNO AS EMPLOYEENO
                        ,FROMMONO AS MONO
                        ,NULL
                        ,NULL
                    FROM TBLWIPMERGECONTENT
                  UNION
                  SELECT 6 AS DTYPE
                        ,N'并批(子)' AS DTYPENAME
                        ,NULL
                        ,TOLOTNO AS LOTNO
                        ,OPNO
                        ,TOLOTQTY AS INPUTQTY
                        ,NULL
                        ,NULL
                        ,NULL
                        ,EVENTTIME AS STARTTIME
                        ,EVENTTIME AS ENDTIME
                        ,TOBASELOTNO AS BASELOTNO
                        ,NULL
                        ,NULL
                        ,TOLOTSERIAL
                        ,NULL
                        ,USERNO AS EMPLOYEENO
                        ,TOMONO AS MONO
                        ,NULL
                        ,NULL
                    FROM TBLWIPMERGECONTENT) C
          WHERE A.BASELOTNO = C.BASELOTNO
                AND A.PRODUCTNO = B.PRODUCTNO
                AND A.PRODUCTVERSION = B.PRODUCTVERSION)
     SELECT a.LOTNO /*生产批号*/
       ,CASE a.DTYPENAME
          WHEN N'暂停' THEN N'暂停'    
          WHEN N'一般' THEN N'一般'
          WHEN N'并批(母)' THEN N'并批(母)'/*#83141修改类型显示*/
          WHEN N'并批(子)' THEN N'并批(子)'/*#83141修改类型显示*/
          WHEN N'分批(母)' THEN N'分批(母)'    /*#82619,81601修改类型显示*/
          WHEN N'分批(子)' THEN N'分批(子)'/*#82619,81601修改类型显示*/
        END DTYPENAME /*类型*/
       ,CASE a.OPNO WHEN N'LOTCREATE' THEN N'开立' ELSE a.OPNO END OPNO /*作业站编号*/
       ,b.OPNAME /*作业名称*/
	   ,e.RONO /*订单编号(20181030 add)*/
	   ,a.PRODUCTNO /*产品编号*/
       ,c.PRODUCTNAME /*产品名称*/
	   ,c.GraphNo
       ,c.ItemSpec /*规格*/
	   ,oe.Description MODescription
       ,isnull (a.INPUTQTY, 0) INPUTQTY /*输入数量*/
       ,isnull (a.GOODQTY, 0) GOODQTY /*良品数*/
	,isnull (a.FAILQTY, 0) FAILQTY /*不良数，#114278，去除原LOSSQTY*/
       ,(SELECT sum(ce.ErrorQTY) AS ErrorQTY
          FROM tblWIPCont_Error ce
               JOIN tblQCReasonBasis rb ON ce.ErrorNo = rb.ReasonNo
         WHERE     rb.ReasonType = 12
               AND rb.ReasonSubType = N'Lack ReasonType'
               AND SCRAPFLAG = 0
               AND ce.LogGroupSerial = a.LogGroupSerial
               AND ce.LotNo = a.LotNo
               AND ce.OPNo = a.OPNo and a.DTYPENAME = N'一般')
          AS LackQTY /*短少数*/
       ,( SELECT sum(ce.ErrorQTY) AS ErrorQTY
          FROM tblWIPCont_Error ce
               JOIN tblQCReasonBasis rb ON ce.ErrorNo = rb.ReasonNo
         WHERE     rb.ReasonType = 11
               AND (rb.ReasonSubType = N'Excess ReasonType' or rb.ReasonSubType = N'ERP_Excess')
               AND SCRAPFLAG = 0
               AND ce.LogGroupSerial = a.LogGroupSerial
               AND ce.LotNo = a.LotNo
               AND ce.OPNo = a.OPNo and a.DTYPENAME =N'一般')
          AS ExcessQTY /*多余数*/
    ,CONVERT (CHAR(16), a.STARTTIME, 120) STARTTIME/*开始时间*/
    ,CONVERT(CHAR(16), a.ENDTIME, 120) ENDTIME/*结束时间*/
    ,(SELECT ROUND(SUM(RESVALUE) / 60,2)
    FROM tblWIPCont_Resource x
    WHERE x.LOTNO = a.LOTNO
            AND x.OPNO = a.OPNO
            AND x.RESCLASS = 0) RealManTime_H /*人时(时)*/       
    ,(SELECT ROUND(SUM(RESVALUE) / 60, 2)
    FROM tblWIPCont_Resource x
    WHERE x.LOTNO = a.LOTNO
            AND x.OPNO = a.OPNO
            AND x.RESCLASS = 1) RealMachineTime_H /*机时(时)*/
    ,a.PROCESSNO /*流程编号*/
    ,a.MONO /*工单编号*/
    ,a.CUSTOMERNO /*客户编号*/
    ,a.BASELOTNO /*主批号*/
    ,d.CUSTOMERNAME /*客户名称*/
    ,a.LOGGROUPSERIAL _LOGGROUPSERIAL
    ,e.CUSTOMERLOTNO /*客户批号*/
    /*20231121 modify by zhaosf for M#0150392: 穎宸6.0:生產批歷程查詢資料錯誤*/
    ,Case WWLD.LotDispType
        When 0 then N'继续生产' /*Go：继续生产*/ 
        When 1 then N'跳站' /*JumpOP：跳站*/
        When 2 then N'跳流程' /*JumpProcess：跳流程*/
        When 3 then N'结束生产' /*Semi Inventory：结束生产*/
        When 7 then N'整批报废'/*Scrap Inventory：整批报废*/
    End as WaitDisposition /*暂停处置*/
    ,PNB1.NodeNo AS ToNodeNo  /*目的站点*/
		
FROM RPT_LotHistory_N a /*M#0066266修正RPT_LotHistory→RPT_LotHistory_N */
LEFT JOIN TBLOPBASIS b
    ON a.OPNO = b.OPNO
LEFT JOIN TBLENTCUSTOMERBASIS d
    ON a.CUSTOMERNO = d.CUSTOMERNO
LEFT JOIN TBLWIPLOTBASIS e
    ON a.LOTNO = e.BASELOTNO
LEFT JOIN TBLPRDPRODUCTBASIS c
    ON a.PRODUCTNO = c.PRODUCTNO and e.PRODUCTVERSION = c.PRODUCTVERSION 
Left join tblWIPWaitLotDisposition WWLD on WWLD.WaitNo=a.WaitNo 
Left Join tblPRSNodeBasis PNB1 on PNB1.NodeID=WWLD.NODEID
LEFT JOIN tblOEMOBasis oe on oe.MONO = a.MONO
where 1=1 
/*{{a.STARTTIME}}*/  
/*{{a.STARTTIME}}*/
/*{{a.PRODUCTNO}}*/  
/*{{c.PRODUCTNAME}}*/
/*{{a.CUSTOMERNO}}*/
/*{{d.CUSTOMERNAME}}*/
/*{{e.RONO}}*/
/*{{a.MONO}}*/
/*{{a.LOTNO}}*/
/*{{a.DTYPENAME}}*/
/*{{c.GraphNo}}*/
/*{{c.ItemSpec}}*/
/*{{oe.Description}}*/
order by a.LOTNO ,a.STARTTIME   /*#122280*/
