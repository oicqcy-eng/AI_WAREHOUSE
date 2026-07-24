#!/bin/bash
# ============================================
# AI-WAREHOUSE — 通用回滚脚本
# 用法: ./rollback.sh <service> <environment> [previous-version]
# 示例: ./rollback.sh vllm staging v2.0.0
# ============================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info()  { echo -e "${BLUE}[INFO]${NC}  $1"; }
log_ok()    { echo -e "${GREEN}[OK]${NC}   $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

if [ $# -lt 2 ]; then
    echo "用法: $0 <service> <environment> [previous-version]"
    echo "示例: $0 vllm staging v2.0.0"
    exit 1
fi

SERVICE="$1"
ENVIRONMENT="$2"
PREVIOUS_VERSION="${3:-}"

# ── 如果未指定版本，从部署日志获取上一版本 ──
if [ -z "$PREVIOUS_VERSION" ]; then
    DEPLOY_LOG="$PROJECT_ROOT/docs/changelogs/deploy.log"
    if [ -f "$DEPLOY_LOG" ]; then
        PREVIOUS_VERSION=$(grep "$SERVICE.*$ENVIRONMENT" "$DEPLOY_LOG" | tail -2 | head -1 | awk '{print $3}')
        if [ -z "$PREVIOUS_VERSION" ]; then
            log_error "未找到 $SERVICE 在 $ENVIRONMENT 的历史版本"
            exit 1
        fi
        log_info "自动检测到上一版本: $PREVIOUS_VERSION"
    else
        log_error "部署日志不存在，请指定版本号"
        exit 1
    fi
fi

log_warn "===== 回滚操作 ====="
log_warn "服务:     $SERVICE"
log_warn "环境:     $ENVIRONMENT"
log_warn "目标版本: $PREVIOUS_VERSION"
echo ""
read -rp "确认回滚？(yes/no): " confirm
if [ "$confirm" != "yes" ]; then
    log_info "已取消回滚"
    exit 0
fi

# ── 执行回滚（使用目标版本重新部署） ──
"$SCRIPT_DIR/deploy.sh" "$SERVICE" "$ENVIRONMENT" "$PREVIOUS_VERSION"

log_ok "回滚完成: $SERVICE → $PREVIOUS_VERSION ($ENVIRONMENT)"
