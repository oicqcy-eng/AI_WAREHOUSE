/*不良原因*/

SELECT case a.REASONTYPE when 11 then '多余'
						 when 12 then '短少'
						 else '不良'
						 END REASONTYPE --例外分类,#117576
  ,B.REASONNO   /*不良原因編號*/
      ,CASE WHEN A.ERRORNO='iSPC_Scrap' THEN 'iSPC判定損壞'
	        WHEN A.ERRORNO='iSPC_Return' THEN 'iSPC判定驗退'
			ELSE B.ReasonName END ReasonName
      ,CONVERT(CHAR(16),A.EVENTTIME,120) EVENT_TIME /*登出時間*/
      ,SUM(A.ERRORQTY) ERRORQTY
      ,A.DESCRIPTION
      ,A.LogGroupSerial _LOGGROUPSERIAL
	  ,a.LOTNO
	  ,a.OPNO   /*#117127，子表增加KEY*/
FROM tblQCReasonBasis B
JOIN tblWIPCont_Error A ON A.ErrorNo=B.ReasonNo
WHERE EXISTS (
  SELECT *
  FROM V_Q05
  WHERE V_Q05._LogGroupSerial=a.LogGroupSerial
  AND V_Q05._LogGroupSerial<>''
/*{{a.LogGroupSerial}}*/
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
GROUP BY B.REASONNO,A.ERRORQTY,A.DESCRIPTION,CONVERT(CHAR(16),a.EVENTTIME,120),A.ERRORNO,B.REASONNAME
,A.DESCRIPTION,A.LogGroupSerial,a.LOTNO,a.OPNO  /*#117127，子表增加KEY*/,a.REASONTYPE /*例外分类,#117576*/
ORDER BY CONVERT(CHAR(16),A.EVENTTIME,120), A.LogGroupSerial
