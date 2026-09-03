# report-board — 控制台风汇报板

> 生成模块化 HTML 汇报版面（投影用）：深墨蓝控制台底 + 青绿信号 + 琥珀警示 + 等宽日期编号。

## 用法

复制 `templates/control-board-template.html` 为 `<主题>.html`，按模板内注释替换 `【】` 占位符、按需删减模块。详见 [SKILL.md](SKILL.md)。

## 实例

| 实例 | 位置 |
|------|------|
| 三厂小簧 9/7 模拟筹备（首个实例，2026-08-19） | `delivery/projects/hw-spring-mes/output/san-chang-xiao-huang/2026-08-19_三厂小簧9-7模拟筹备进展汇报_主持人版.html` |

## 版本

- v1.0（2026-08-19 定版）：6 标准模块 + 收尾；深墨蓝控制台主题
- v1.1（2026-09-03）：新增 `scripts/self-check.sh` 机器自检（无残留【】/title/TODO/未闭合属性/体积），替代纯目测

## 自检脚本

`bash skills/report-board/scripts/self-check.sh <产出.html>`

| 检查项 | 判定 |
|--------|------|
| 无残留【】占位符 | 模板未替换即此症状 |
| 存在 `<title>` | 缺标题 = 命名/交付不完整 |
| 无 TODO/待补残留 | 内容未写完 |
| 无未闭合属性引号 | 复制模板破坏结构 |
| 文件 >2KB | 空壳/半成品拦截 |

全部 PASS（exit 0）才可交付；有 FAIL（exit 1）修复后重跑。
