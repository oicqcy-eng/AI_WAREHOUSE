#!/usr/bin/env bash
# scan-sensitive.sh — delivery-review 脱敏机器扫描脚本
# 用法: bash skills/delivery-review/scripts/scan-sensitive.sh <文件或目录> [--extra <自定义敏感词表>]
# 说明: 扫描交付物中常见敏感模式(密钥/token/手机号/邮箱/IP/账号密码明文) + 可选自定义词表(每行一个词,如真实客户名)。
#       命中则打印 文件:行:内容 并 exit 1（提示人工复核），无命中 exit 0。Windows 用 Git Bash 运行。
set -u

target="${1:?用法: scan-sensitive.sh <文件或目录> [--extra <敏感词表>]}"
[ -e "$target" ] || { echo "路径不存在: $target"; exit 2; }

# 定位可扫描文件：文本类才扫，跳过二进制/图片/压缩包
mapfile -t files < <(find "$target" -type f \
  \( -name '*.md' -o -name '*.txt' -o -name '*.html' -o -name '*.htm' \
     -o -name '*.csv' -o -name '*.json' -o -name '*.xml' -o -name '*.sql' \
     -o -name '*.yml' -o -name '*.yaml' -o -name '*.ini' -o -name '*.cfg' \
     -o -name '*.sh' -o -name '*.py' -o -name '*.js' \) 2>/dev/null)

if [ "${#files[@]}" -eq 0 ]; then
  echo "未发现可扫描的文本文件(仅扫 md/txt/html/csv/json/xml/sql/yml/sh/py 等)"
  exit 0
fi

echo "扫描 ${#files[@]} 个文本文件: $target"
echo "======== 常见敏感模式 ========"
hits=0

# 模式组: 密钥/token 长串 | 手机号 | 邮箱 | IP | 明文口令
while IFS= read -r line; do
  [ -n "$line" ] || continue
  echo "$line"
  hits=$((hits + 1))
done < <(grep -rniE \
  -e 'sk-[A-Za-z0-9_-]{8,}|ghp_[A-Za-z0-9]{20,}|AKIA[0-9A-Z]{16}|xox[baprs]-[A-Za-z0-9-]{10,}|-----BEGIN [A-Z ]*PRIVATE KEY-----|Bearer [A-Za-z0-9._-]{20,}' \
  -e '(^|[^0-9])1[3-9][0-9]{9}([^0-9]|$)' \
  -e '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' \
  -e '([0-9]{1,3}\.){3}[0-9]{1,3}' \
  -e '(password|passwd|pwd|secret|api[_-]?key|access[_-]?key)[[:space:]]*[=:][[:space:]]*\S+' \
  "${files[@]}" 2>/dev/null | sed 's/^/  /')

# 可选: 自定义词表(每行一个敏感词,如真实客户名/人员名)
if [ "${2:-}" = "--extra" ]; then
  extra="${3:?--extra 需要词表文件路径}"
  if [ -f "$extra" ]; then
    echo "======== 自定义敏感词表 ($extra) ========"
    while IFS= read -r w; do
      [ -z "$w" ] && continue
      while IFS= read -r line; do
        [ -n "$line" ] || continue
        echo "  [词: $w] $line"
        hits=$((hits + 1))
      done < <(grep -niF -- "$w" "${files[@]}" 2>/dev/null)
    done < "$extra"
  else
    echo "!! 词表不存在: $extra"
  fi
fi

echo "======== 结果 ========"
if [ "$hits" -eq 0 ]; then
  echo "未命中敏感模式"
  exit 0
else
  echo "命中 $hits 处疑似敏感内容——逐条人工复核(有些是误报:文档里的示例IP/邮箱/代码样例),确认真实敏感信息后按 delivery-review 合规步骤脱敏"
  exit 1
fi
