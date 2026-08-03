# MES项目汇报 Agent

## 能力定义
- 汇总实施进展、模块状态、风险与待办，生成项目汇报
- 引用 `docs/changelogs/`、各模块 runbooks 与监控数据
- 输出周报/月报/里程碑报告（含图表）

## 依赖
- 数据: `operations/reporting/`、`operations/kanban/`、各模块 `monitor/`
- 文档: `docs/changelogs/`
- 模型推理: `ai/serving/`

## 目录说明
| 目录 | 内容 |
|------|------|
| config/ | Agent 配置(模型/参数/路由) |
| prompt/ | 汇报类 prompt + few-shot |
| knowledge/ | 汇报规范 / 模板 / 案例 |
| tools/ | 报表查询 / 图表生成 / 文档导出脚本 |
| workflow/ | 汇报生成流程定义 |
| data/ | 汇报数据字典 / 样例 |
| evaluation/ | 汇报质量测试集 / 标准答案 |
| runbooks/ | 使用 / 维护 / 故障手册 |

## 使用
（待填充：启动方式、调用示例）
