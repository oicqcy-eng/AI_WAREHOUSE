#!/bin/bash
# ============================================
# AI-WAREHOUSE — 模块回滚脚本
# 用法: ./rollback.sh <module> <environment> [previous-version]
# ============================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

RED='\033[0;31m'; YELLOW='\033[1;33m'; NC='\033[0m'
log_warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

if [ $# -lt 2 ]; then
    echo "用法: $0 <module> <environment> [previous-version]"
    exit 1
fi

MODULE="$1"
ENVIRONMENT="$2"
PREVIOUS_VERSION="${3:-}"

MODULE_DIR="$PROJECT_ROOT/$MODULE"
if [ ! -d "$MODULE_DIR/deploy" ]; then
    log_error "模块 $MODULE 不存在"
    exit 1
fi

log_warn "===== 回滚: $MODULE ($ENVIRONMENT) ====="

# 停止当前版本
docker compose -f "$MODULE_DIR/deploy/docker-compose.yml" -p "aiw-$MODULE" down

# 如果有指定版本，用 deploy.sh 重新部署
if [ -n "$PREVIOUS_VERSION" ]; then
    bash "$SCRIPT_DIR/deploy.sh" "$MODULE" "$ENVIRONMENT" "$PREVIOUS_VERSION"
else
    # 重新启动当前配置
    docker compose -f "$MODULE_DIR/deploy/docker-compose.yml" -p "aiw-$MODULE" up -d
fi

echo "回滚完成: $MODULE"
