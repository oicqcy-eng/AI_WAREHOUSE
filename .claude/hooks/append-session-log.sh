#!/bin/bash
# 会话结束自动追加日志到 BUILDING.md
# 触发: Claude Code Stop hook
# 作用: 每次会话结束时，把本次会话产生的 commit 记录追加到 BUILDING.md 的"自动日志"区
#       作为"不会漏记"的兜底；深度决策仍靠对话中提炼。

set -euo pipefail

# 定位仓库根（脚本位于 .claude/hooks/）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
BUILDING="$PROJECT_ROOT/BUILDING.md"

# 会话开始时间（Claude Code 环境变量，可能为空）
SESSION_ID="${CLAUDE_SESSION_ID:-unknown}"
TS="$(date '+%Y-%m-%d %H:%M')"

# 本次会话期间的新提交：取最近 10 条，按 hash 去重（防止同 commit 被多次追加）
NEW_COMMITS="$(cd "$PROJECT_ROOT" && git log --oneline -10 2>/dev/null \
  | awk '!seen[$1]++ { print "    " $0 }')" || NEW_COMMITS=""

# 跨 session 去重：过滤掉 BUILDING.md 中已存在的 commit hash
# 用 awk 做 hash 字段匹配（第一列），避免 grep -vFxf 整行匹配的格式不兼容问题
if [ -n "$NEW_COMMITS" ] && [ -f "$BUILDING" ]; then
  _EXISTING_FILE=$(mktemp)
  grep -oE '[a-f0-9]{7}' "$BUILDING" 2>/dev/null | sort -u > "$_EXISTING_FILE" || true
  if [ -s "$_EXISTING_FILE" ]; then
    NEW_COMMITS="$(echo "$NEW_COMMITS" | awk -v file="$_EXISTING_FILE" '
      BEGIN { while ((getline line < file) > 0) known[line]=1 }
      { if (!($1 in known)) print }
    ' || true)"
  fi
  rm -f "$_EXISTING_FILE"
fi

# 如果无新提交，跳过（避免空条目刷屏）
if [ -z "$NEW_COMMITS" ]; then
  echo "ℹ️  本次会话无新提交，跳过日志追加"
  exit 0
fi

# 追加到 "## 🗒️ 自动会话日志" 区（若不存在则创建）
LOG_ENTRY="### $TS (session: ${SESSION_ID:0:8})
本次会话相关提交（去重，最近10条）:
\`\`\`
$NEW_COMMITS
\`\`\`
"

if grep -q "## 🗒️ 自动会话日志" "$BUILDING"; then
  # 在日志区标题后插入最新条目（新条目在最前）
  awk -v entry="$LOG_ENTRY" '
    /^## 🗒️ 自动会话日志/ { print; print ""; print entry; skip=1; next }
    { if (skip && /^### /) skip=0 }
    { if (!skip) print }
  ' "$BUILDING" > "$BUILDING.tmp" && mv "$BUILDING.tmp" "$BUILDING"
else
  cat >> "$BUILDING" <<EOF2

---

## 🗒️ 自动会话日志

> 由 Stop hook 自动追加（兜底记录，深度决策见上方阶段叙述）。

$LOG_ENTRY
EOF2
fi

echo "✅ 已追加会话日志到 BUILDING.md"
exit 0
