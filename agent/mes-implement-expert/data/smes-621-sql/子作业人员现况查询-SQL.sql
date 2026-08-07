SELECT * FROM (
SELECT  A.UserNo,
       A.UserName,
       A.DepartmentNo AS _DepartmentNo,
       C.DepartmentName AS _DepartmentName,
       D.ShiftName, /*班別*/
       CASE when B._SubUserNo is null then N'闲置' else N'已上工' end as UserStatus, /*人員狀態*/
       B.*
  FROM TBLUSRUSERBASIS A
  LEFT JOIN (
      select UserNo as _SubUserNo, BaseLotNo, prod_basis.ProductNo, prod_basis.ProductName, prod_basis.ProductVersion, prod_basis.ItemSpec,
        op_basis.OpNo, op_basis.OpName, subop.SubOPNo, subop.SubOPName, (ISNULL(pstate.qty, 0) + ISNULL(preport.qty, 0)) CurQTY, ISNULL(plog.qty, 0) CompleteQTY 
      FROM TBLWIPOPERATORSTATE op_state 
      JOIN TBLWIPLOTBASIS plot_basis ON op_state.LoginPlaceNo = plot_basis.BaseLotNo
      JOIN TBLPRDProductBasis prod_basis ON plot_basis.PRODUCTNO  = prod_basis.PRODUCTNO AND plot_basis.PRODUCTVERSION = prod_basis.PRODUCTVERSION 
      JOIN TBLOPBasis op_basis on op_state.OpNo = op_basis.OpNo
      JOIN TBLPRDSubOPBasis subop ON op_state.SubOpNo = subop.SubOpNo
      LEFT JOIN (select LOTNO, OPNO, sum(CurQty) Qty from  TBLWIPLOTSTATE group by LOTNO, OPNO) pstate ON pstate.LotNo = plot_basis.BaseLotNo AND  pstate.OpNo = op_basis.OpNo
      LEFT JOIN (select LOTNO, OPNO, sum(InputQty) Qty from  TBLWIPLOTLOG_REPORT group by LOTNO, OPNO ) preport ON preport.LotNo = plot_basis.BaseLotNo AND  preport.OpNo = op_basis.OpNo
      LEFT JOIN (select LOTNO, OPNO, SUBOPNO, sum(GOODQTY + SCRAPQTY + LACKQTY) Qty from  tblWIPSubOPLog_Report group by LOTNO, OPNO, SUBOPNO) plog 
        ON plog.LotNo = plot_basis.BaseLotNo AND plog.OpNo = op_basis.OpNo AND plog.SubOpNo = op_state.SubOpNo
    ) B ON B._SubUserNo = A.UserNo
  LEFT JOIN TBLUsrDepartmentBasis C ON C.DepartmentNo = A.DepartmentNo
  LEFT JOIN TBLUsrShiftBasis D ON D.ShiftNo = A.ShiftNo
where A.ISSUESTATE = '2' )  W