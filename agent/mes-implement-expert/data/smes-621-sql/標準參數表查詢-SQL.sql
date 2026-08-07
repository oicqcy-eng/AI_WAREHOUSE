SELECT
  *
FROM (SELECT
  A.EquipmentNo /*設備編號*/,
  A.ProductNo /*產品編號*/,
  A.AccessoryType /*模治具類別*/,
  A.OPNo /*作業站編號*/,
  A.RecipeVer /*版本*/,
  CASE A.ProdPhase
    WHEN 0 THEN N'试模'
    WHEN 1 THEN N'试样'
    WHEN 2 THEN N'试产'
    WHEN 3 THEN N'量产'
  END ProdPhaseNM/*生產階段*/,
  A.ProgramNo /*程式編號*/,
  A.Description AS RB_Description /*Recipe說明*/,
  (SELECT
    tb.PhaseName
  FROM tblINJPhaseBasis tb
  WHERE tb.ParamPhase = b.ParamPhase)
  ParamPhaseNM/*階段*/,
  B.ParamCategoryName/*參數分類*/,
  B.ParamSection /*段數*/,
  B.StdValue /*標準值*/,
  B.MaxValue /*上限值*/,
  B.MinValue /*下限值*/,
  CASE
    WHEN B.NeedCheck = 1 THEN N'是'
    ELSE N'否'
  END NeedCheck/*需檢核*/,
  B.Description AS RD_Description/*明細說明*/,
  B.ParamNo AS ParamNos/*參數編號*/,
  B.ParamName /*參數名稱*/,
  B.HighTolerance /*允許上限*/,
  B.LowerTolerance /*允許下限*/,
  CASE B.ToleranceType
    WHEN 0 THEN N'百分比'
    WHEN 1 THEN N'实际值'
  END ToleranceTypeNM /*允許類型*/
FROM tblINJRecipeBasis A
JOIN tblINJRecipeDetail B
  ON A.RecipeNo = B.RecipeNo
WHERE Invalid = 0) c