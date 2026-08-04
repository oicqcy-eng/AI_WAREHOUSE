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

# 本次会话期间的新提交（相对上次 hook 运行后的新提交；简单起见取最近 5 条）
NEW_COMMITS="$(cd "$PROJECT_ROOT" && git log --oneline -5 2>/dev/null | sed 's/^/    /')"

# 追加到 "## 🗒️ 自动会话日志" 区（若不存在则创建）
LOG_ENTRY="### $TS (session: ${SESSION_ID:0:8})
本次会话相关提交（最近5条）:
\`\`\`
$NEW_COMMITS
\`\`\`
"

if grep -q "## 🗒️ 自动会话日志" "$BUILDING"; then
  # 在日志区标题后插入最新条目
  awk -v entry="$LOG_ENTRY" '
    /^## 🗒️ 自动会话日志/ { print; print ""; print entry; skip=1; next }
    { if (skip && /^### /) skip=0 }
    { if (!skip) print }
  ' "$BUILDING" > "$BUILDING.tmp" && mv "$BUILDING.tmp" "$BUILDING"
else
  cat >> "$BUILDING" <<EOF

---

## 🗒️ 自动会话日志

> 由 Stop hook 自动追加（兜底记录，深度决策见上方阶段叙述）。

$LOG_ENTRY
EOF
fi

echo "✅ 已追加会话日志到 BUILDING.md"
exit 0
