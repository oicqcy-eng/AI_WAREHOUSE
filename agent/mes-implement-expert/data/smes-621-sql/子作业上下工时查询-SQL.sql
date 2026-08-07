select BaseLotNo, 
    prod_basis.ProductNo, 
    prod_basis.ProductName, 
    prod_basis.ProductVersion, 
    prod_basis.ItemSpec,
    op_basis.OpNo, 
    op_basis.OpName, 
    subop.SubOPNo,
    subop.SubOPName,
    shift.ShiftName,
    op_log.UserNo,
    user_basis.UserName,
    LOGINDATE,
    LOGOUTDATE,
    WORKTIME AS WorkMin
FROM TBLWIPOPERATORLOG op_log 
JOIN TBLWIPLOTBASIS plot_basis ON op_log.LoginPlaceNo = plot_basis.BaseLotNo
JOIN TBLPRDProductBasis prod_basis ON plot_basis.PRODUCTNO  = prod_basis.PRODUCTNO AND plot_basis.PRODUCTVERSION = prod_basis.PRODUCTVERSION 
JOIN TBLOPBasis op_basis on op_log.OpNo = op_basis.OpNo
JOIN TBLPRDSubOPBasis subop ON op_log.SubOpNo = subop.SubOpNo
JOIN TBLUSRUSERBASIS user_basis ON user_basis.UserNo = op_log.UserNo
JOIN TBLUsrShiftBasis shift ON shift.ShiftNo = CASE op_log.ShiftNo WHEN 'N/A' THEN user_basis.ShiftNo ELSE user_basis.ShiftNo END  
	/*#79646因上工時若非班別設定時間，則寫入N/A，現另抓取使用者預設班別資料*/