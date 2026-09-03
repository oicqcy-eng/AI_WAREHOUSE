#!/usr/bin/env bash
# self-check.sh — report-board 产出 HTML 自检脚本（机器兜底，替代纯目测）
# 用法: bash skills/report-board/scripts/self-check.sh <html文件>
# 说明: 任一项 FAIL 则 exit 1；全部 PASS exit 0。Windows 用 Git Bash 运行。
set -u

f="${1:?用法: self-check.sh <html文件>}"
[ -f "$f" ] || { echo "FAIL 文件不存在: $f"; exit 1; }

fail=0
chk() { # chk <名称> <0通过|1失败> <失败说明>
  if [ "$2" -eq 0 ]; then echo "PASS  $1"; else echo "FAIL  $1 — $3"; fail=1; fi
}

# 1. 无残留 【】 占位符（模板未替换即此症状）
n=$(grep -o '【[^】]*】' "$f" | wc -l | tr -d ' ')
chk "无残留【】占位符" $((n == 0 ? 0 : 1)) "发现 $n 处未替换占位符"

# 2. <title> 存在
if grep -qi '<title>[^<]\+</title>' "$f"; then t=0; else t=1; fi
chk "存在 <title>" "$t" "页面缺少标题（命名规范 <日期>_<主题>_主持人版）"

# 3. 无 TODO/占位/待补字样（防止内容没写完就交付）
n=$(grep -ciE 'TODO|FIXME|待补|占位|XXXX' "$f" || true)
chk "无 TODO/待补残留" $((n == 0 ? 0 : 1)) "发现 $n 处待补标记"

# 4. 无中文引号误入 class/id 属性区（常见于复制模板时破坏结构）
#    仅作提示项，命中不判死（有些正文合理含引号）——此处检查属性区残缺 `" ` 断行
bad=$(grep -nE '="[^"]*$' "$f" | wc -l | tr -d ' ')
chk "无未闭合属性引号" $((bad == 0 ? 0 : 1)) "发现 $bad 行属性引号可能未闭合"

# 5. 文件体积合理（空壳/半成品常 <2KB）
size=$(wc -c < "$f" | tr -d ' ')
chk "文件体积正常(>2KB)" $((size >= 2048 ? 0 : 1)) "仅 $size 字节，疑似空壳模板"

echo "----"
if [ "$fail" -eq 0 ]; then echo "结果: 全部 PASS，可交付"; else echo "结果: 有 FAIL，修复后重跑"; fi
exit "$fail"
