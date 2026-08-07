SELECT 
    a0.QCORDER /*點檢次序*/
    ,a0.QCITEM /*檢查項目*/
	,case a0.QCTYPE when 0 then N'0:標准值' 
	                when 1 then N'1:範圍值' 
	                when 2 then N'2:顯示訊息' 
					when 3 then N'3:輸入數據' 
	 end as QCTYPE
	,case a0.QCRESULT when 0 then '0:OK' else '1:NG' end as QCRESULT /*結果 0:OK 1:NG*/
    ,a0.INPUTVALUE  /*輸入值*/
    ,a0.MINIVALUE /*最小值*/
    ,a0.MAXIVALUE /*最大值*/
	 ,a0.QCListSerial
	 ,CONVERT(varchar,a.CreateDate,120) CreateDate
	 ,a.EquipmentNo         /*#117251，增加三個跟主表關聯的字段，從而在彙出的數據中可看出檢驗項目與設備的對應關系*/
  ,b.EquipmentName /*#0119133，增加设备名称*/
  ,FILENAME
FROM tblWIPEQPQCListDetail a0
JOIN TBLWIPEQPQCLISTLOG a ON a0.QCLISTSERIAL = a.QCLISTSERIAL
  join TBLEQPEQUIPMENTBASIS b on a.EQUIPMENTNO=b.EQUIPMENTNO  /*#0119133，增加设备名称*/
WHERE a0.QCListSerial IS NOT NULL