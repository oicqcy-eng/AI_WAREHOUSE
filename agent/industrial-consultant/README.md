# 工业数字化顾问 Agent

## 能力定义
- 面向工业企业数字化诊断：评估现状、识别机会、给出演进路线
- 覆盖 MES、IIoT、AI 应用、数据治理等方向
- 输出诊断报告与分阶段实施建议

## 依赖
- 数据: `operations/iiot/`、`manufacturing/*/`、`ai/*/`
- 模型推理: `ai/serving/`
- 知识检索: `ai/vector-db/`

## 目录说明
| 目录 | 内容 |
|------|------|
| config/ | Agent 配置(模型/参数/路由) |
| prompt/ | 咨询类 prompt + few-shot |
| knowledge/ | 行业知识 / 案例 / 对标资料 |
| tools/ | 评估问卷 / 评分脚本 / 报告生成 |
| workflow/ | 诊断咨询流程定义 |
| data/ | 评估数据模型 / 样本 |
| evaluation/ | 诊断质量测试集 / 标准答案 |
| runbooks/ | 使用 / 维护 / 故障手册 |

## 使用
（待填充：启动方式、调用示例）
