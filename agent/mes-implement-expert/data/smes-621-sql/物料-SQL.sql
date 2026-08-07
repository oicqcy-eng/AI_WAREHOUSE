/*物料*/

SELECT A.MaterialNo ,
       c.MATERIALNAME  ,
       c.MATERIALSPEC,
       COALESCE(B.LotQty, A.UseQty) AS UseQty ,
       B.MaterialLotNo,
       A.MaterialType   ,
       A.UnitNo  ,
       A.LogGroupSerial
        ,gr.LOTNO
	  ,gr.OPNO
  FROM 
       (  SELECT LOGGROUPSERIAL,
                 MATERIALNO,
                 MaterialLotNo,
                 SUM (LOTQTY) LOTQTY
            FROM tblWIPCont_MaterialLot
           WHERE LOTQTY > 0
        GROUP BY LOGGROUPSERIAL, MATERIALNO, MaterialLotNo) B
       RIGHT OUTER JOIN (  SELECT LOGGROUPSERIAL,
                                  MATERIALNO,
                                  MATERIALTYPE,
                                  UNITNO,
                                  SUM (USEQTY) USEQTY
                             FROM tblWIPCont_Material
                            WHERE USEQTY > 0
                         GROUP BY LOGGROUPSERIAL,
                                  MATERIALNO,
                                  MATERIALTYPE,
                                  UNITNO) A
          ON  A.MaterialNo = B.MaterialNo
             AND A.LogGroupSerial = B.LogGroupSerial
LEFT JOIN TBLMTLMATERIALBASIS c ON A.MATERIALNO = c.MATERIALNO
join TBLWIPLOTLOG_REPORT gr on gr.LOGGROUPSERIAL=a.LOGGROUPSERIAL
WHERE EXISTS (
  SELECT *
  FROM V_Q05
  WHERE V_Q05._LOGGROUPSERIAL=a.LogGroupSerial
  AND V_Q05._LOGGROUPSERIAL IS NOT NULL
/*{{V_Q05.LOTNO}}*/
/*{{V_Q05.STARTTIME}}*/
/*{{V_Q05.STARTTIME}}*/
/*{{V_Q05.PRODUCTNO}}*/
/*{{V_Q05.PRODUCTNAME}}*/
/*{{V_Q05.CUSTOMERNO}}*/
/*{{V_Q05.CUSTOMERNAME}}*/
/*{{V_Q05.RONO}}*/
/*{{V_Q05.MONO}}*/
/*{{V_Q05.DTYPENAME}}*/
)
ORDER BY A.LogGroupSerial, A.MATERIALNO