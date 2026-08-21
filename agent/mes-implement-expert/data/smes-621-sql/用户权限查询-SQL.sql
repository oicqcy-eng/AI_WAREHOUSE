/*用户权限排查四视角 —— H5端无权限/无按钮/作业群组权限核对（通用模板，2026-08-21 v1）
 * 库: sMES 共库（192.168.200.18/sMES_Home_Prod，--profile home；重庆独立库 --profile cq 表同名）
 * 用法: node query-mes.js 本文件 --profile home -p userno=HW0403 --show 1|2|3|4
 *   userno=登录账号（必填，如 HW0403）。不带 --show 默认只显示第一个查询
 * 来源: 2026-08-21 三厂小簧「派工调度中心无按钮」排查实测归纳；权限编号对照 h5-作业群组权限清单.md
 * 用途: 用户看不到某功能按钮（派工/报工/报表等）时，按 用户→群组→群组权限→控件禁用 四层定位——
 *   ① 用户主档（TBLUSRUSERBASIS）      → 用户是否存在/启用（ISSUESTATE=2 正常）
 *   ② 群组关联（TBLUSRUSERGROUP + TBLUSRGROUPBASIS）→ 用户绑定到哪个作业群组、群组状态
 *   ③ 群组权限明细（TBLUSRGROUPPRIV）  → 群组到底勾了哪些权限编号（核心，对照权限清单查缺口）
 *   ④ 权限控件禁用（TBLUSRGROUPPRIVCONTROL）→ 是否有细分控件被禁（有记录才需关注）
 *
 * ── 口径说明（务必先读）────────────────────────────
 * [①] TBLUSRUSERBASIS: USERNO=登录账号  USERNAME=姓名  GUID=数据键值（关联用）
 *   ISSUESTATE=2 正常启用；USERLEVEL/DEPARTMENTNO 辅助识别岗位/部门
 * [②] TBLUSRUSERGROUP: GROUPNO=群组编号（无 GROUPID 列，勿写错列名）  GROUPTYPE=群组类型(共库实测几乎全为0)
 *   群组名在 TBLUSRGROUPBASIS.GROUPNAME；两表 ISSUESTATE 均 2=启用
 * [③] TBLUSRGROUPPRIV: 核心权限明细表。PRIVTYPE 语义（实测归纳）——
 *   9=菜单权限编号（如 B0101 生产批开立/B0106 批次开立）    → H5 端按钮显示主要看此类
 *   0=平台权限编号（如 LOT CREATE / DISPATCH OPERATION 派工作业 / A03 派工看板）
 *   8=按钮级 CRUD（Add/Edit/Delete/View/Export…）
 *   PRIVISSUE=1 生效。权限编号↔按钮映射见 data/smes-621/h5-作业群组权限清单.md
 * [④] TBLUSRGROUPPRIVCONTROL: 空表=无控件禁用（本次实测 SCXH-PLN001 为 0 行）
 *
 * ⚠️ 库内权限齐全 ≠ H5 端立即生效：H5 端登录时拉取权限快照，改权限后需重新登录/清缓存；
 *    权限已配置多日仍无效 → 找 DS（鼎捷）确认群组是否"发布生效"，别急着改库。
 * 排障卡: delivery/projects/hw-spring-mes/ops-knowledge/2026-08-21_三厂小簧_sMES_派工调度中心无权限按钮.md
 */

/*① 用户主档 —— 确认用户存在与启用状态 */
SELECT USERNO                       AS 登录账号
      ,USERNAME                     AS 姓名
      ,ISSUESTATE                   AS 状态
      ,USERLEVEL                    AS 用户等级
      ,DEPARTMENTNO                 AS 部门
      ,TITLENO                      AS 职务
      ,SHIFTNO                      AS 班别
      ,GUID                         AS 数据键值
FROM TBLUSRUSERBASIS
WHERE USERNO = '{{userno}}';

/*② 群组关联 —— 用户绑定到哪个作业群组（关联 TBLUSRGROUPBASIS 取群组名） */
SELECT ug.USERNO                    AS 登录账号
      ,ug.GROUPNO                   AS 群组编号
      ,gb.GROUPNAME                 AS 群组名称
      ,ug.GROUPTYPE                 AS 群组类型
      ,ug.ISSUESTATE                AS 用户群组状态
      ,gb.ISSUESTATE                AS 群组主档状态
      ,ug.CreateDate                AS 建立时间
FROM TBLUSRUSERGROUP ug
LEFT JOIN TBLUSRGROUPBASIS gb ON ug.GROUPNO = gb.GROUPNO
WHERE ug.USERNO = '{{userno}}';

/*③ 群组权限明细 —— 该群组全部权限编号（对照 h5-作业群组权限清单.md 查缺口） */
SELECT p.PRIVTYPE                   AS 权限类型
      ,p.PRIVNO                     AS 权限编号
      ,p.PRIVISSUE                  AS 是否生效
      ,p.CreateDate                 AS 建立时间
FROM TBLUSRGROUPPRIV p
WHERE p.GROUPNO IN (SELECT GROUPNO FROM TBLUSRUSERGROUP WHERE USERNO = '{{userno}}')
ORDER BY p.PRIVTYPE, p.PRIVNO;

/*④ 权限控件禁用 —— 该群组是否有细分控件被禁（正常应 0 行） */
SELECT GROUPNO                      AS 群组编号
      ,PRIVNO                       AS 权限编号
      ,CONTROLNAME                  AS 禁用控件名
FROM TBLUSRGROUPPRIVCONTROL
WHERE GROUPNO IN (SELECT GROUPNO FROM TBLUSRUSERGROUP WHERE USERNO = '{{userno}}')
ORDER BY PRIVNO;
