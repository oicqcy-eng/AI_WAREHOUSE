# MES实施专家 Agent

## 能力定义
- 基于鼎华SMES业务模型与仓库资产，输出实施咨询、模块规划、差异分析
- 将业务需求映射到 `base/`、`manufacturing/`、`operations/` 模块
- 生成实施路线图与部署建议

## 依赖
- 业务数据: `base/master-data/`、`manufacturing/*/`、`operations/*/`
- 模型推理: `ai/serving/`
- 知识检索: `ai/vector-db/`（向量数据），`knowledge/` 存引用清单

## 目录说明
| 目录 | 内容 |
|------|------|
| config/ | Agent 配置(模型/参数/路由) |
| prompt/ | system/role/task prompt + few-shot |
| knowledge/ | 业务知识引用清单 / FAQ / SOP / 案例 |
| tools/ | MES 接口定义 / SQL 模板 / 分析脚本 |
| workflow/ | 实施咨询流程定义 |
| data/ | 数据字典 / 样本数据 |
| evaluation/ | 测试问题库 / 标准答案 / 准确率 |
| runbooks/ | 使用 / 维护 / 故障手册 |

## 使用
（待填充：启动方式、调用示例）
