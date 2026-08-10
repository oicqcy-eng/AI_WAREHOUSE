-- ============================================================================
-- U9 ERP 发料查询（MES ← U9 发料数据同步取数）
-- ============================================================================
-- 来源   : delivery/inbox/SQL/U9_ERP发料查询SQL.docx（2026-07-06 归档）
-- 用途   : 从 U9（用友 ERP）的 ESB_IssueWoItem_Queue 发料队列表取 1 条待同步记录，
--          供 MES 侧消费发料数据（工单扫码上料校验 / 发料数据拉取）
-- 关键逻辑:
--   1. 只取 sync_status = 0（待同步）的记录
--   2. exists 校验：工单必须已在 MES 的 TBLOEMOBASIS 存在（MONO 匹配），
--      避免把 MES 尚不存在的工单发料数据推入
--   3. std_qty 标准用量：优先取领料单(MO_MOPickList)算出的 pl.std_qty，
--      为空时回退队列自带 std_qty（isnull 双源兜底）
--   4. 单位映射: 公斤 → W013、公斤(5位) → W016（U9 单位码 → sMES 单位码）
--   5. 领料单标准用量按 主料(IsSubstitute=0) union all 替代料(IsSubstitute=1) 两段求
--   6. 日期字段统一 convert(varchar(19),...,120) 转可读格式
-- 注意   : 本查询不含连接串/账号/密码/IP（纯接口契约 SQL，无敏感信息）
-- 关联   : 重庆调拨条码问题——U9 领料表(MO_MOPickList)与发料队列均无物料条码字段，
--          MES 侧扫码上料校验因此受阻（2026-07-06 评估不可行，见 task T-c038ddec12）
-- ============================================================================

SELECT top(1) * FROM (select
    q.doc_type_no,
    q.doc_no,
    convert(varchar(19), q.create_date, 120) as create_date,
    q.biz_status,
    q.header_remark,
    q.applicant_no,
    q.workstation_no,
    q.seq,
    q.wo_no,
    q.item_no,
    q.qpa_molecular,
    q.qpa_denominator,
    isnull(pl.std_qty, q.std_qty) as std_qty,
    q.qty,
    case
        when ltrim(rtrim(q.unit_no)) = N'公斤' then 'W013'
        when ltrim(rtrim(q.unit_no)) = N'公斤(5位)' then 'W016'
        else q.unit_no
    end as unit_no,
    q.item_type,
    convert(varchar(19), q.input_datetime, 120) as input_datetime,
    q.warehouse_no,
    q.location_no,
    q.lot_no,
    convert(varchar(19), q.expiry_date, 120) as expiry_date,
    q.item_feature_no,
    q.detail_remark,
    q.positive_negative,
    q.replaced_item_no,
    q.replaced_qty,
    q.replaced_type,
    q.issue_to_type,
    q.sub_type,
    q.replaced_item_feature_no,
    q.op_no,
    q.sync_status
from dbo.ESB_IssueWoItem_Queue q
left join
(
    select
        aa.wo_no,
        aa.item_no,
        aa.replaced_item_no,
        aa.sub_type,
        aa.std_qty
    from
    (
        select
            A.ID,
            C.ID as woitemid,
            A.DocNo as wo_no,
            D.Code as item_no,
            D.Name as item_name,
            round(STDReqQty / A.ProductQty, 8) as std_qty,
            STDReqQty as qty,
            E.Code as unit_no,
            WasteRate as shrinkage_rate,
            B1.Version as item_version,
            D.Code as replaced_item_no,
            round(STDReqQty / A.ProductQty, 8) as replaced_qty,
            0 as sub_type
        from MO_MO A
        left join MO_MOPickList C
            on A.ID = C.MO
        left join CBO_ItemMaster D
            on C.ItemMaster = D.ID
        inner join Base_UOM E
            on C.IssueUOM = E.ID
        left join CBO_ItemMasterVersion B1
            on C.ItemVersion = B1.ID
        where IsSubstitute = 0
        union all
        select
            A.ID,
            C.ID as woitemid,
            A.DocNo as wo_no,
            D.Code as item_no,
            D.Name as item_name,
            round(STDReqQty / A.ProductQty, 8) as std_qty,
            STDReqQty as qty,
            E.Code as unit_no,
            WasteRate as shrinkage_rate,
            B1.Version as item_version,
            B.Code as replaced_item_no,
            round(STDReqQty / A.ProductQty, 8) as replaced_qty,
            0 as sub_type
        from MO_MO A
        left join MO_MOPickList C
            on A.ID = C.MO
        left join CBO_ItemMaster D
            on C.ItemMaster = D.ID
        left join CBO_ItemMaster B
            on C.SubstitutedItem = B.ID
        inner join Base_UOM E
            on C.IssueUOM = E.ID
        left join CBO_ItemMasterVersion B1
            on C.ItemVersion = B1.ID
        where IsSubstitute = 1
    ) aa
) pl
    on ltrim(rtrim(pl.wo_no)) = ltrim(rtrim(q.wo_no))
   and ltrim(rtrim(pl.item_no)) = ltrim(rtrim(q.item_no))
where q.sync_status = 0
  and exists
  (
      select 1
      from [MES].[sMES_Home_Prod].[dbo].[TBLOEMOBASIS] M
      where ltrim(rtrim(M.MONO)) = ltrim(rtrim(q.wo_no))
  )
  )  A Where 1 =1
