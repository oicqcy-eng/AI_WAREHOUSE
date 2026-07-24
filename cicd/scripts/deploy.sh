#!/bin/bash
# ============================================
# AI-WAREHOUSE — 模块部署脚本
# 用法: ./deploy.sh <module> <environment> [version]
# 示例: ./deploy.sh quality dev v1.2.0
# ============================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
log_info()  { echo -e "${BLUE}[INFO]${NC}  $1"; }
log_ok()    { echo -e "${GREEN}[OK]${NC}   $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

if [ $# -lt 2 ]; then
    echo "用法: $0 <module> <environment> [version]"
    echo "模块: quality, equipment, production, system, ai-serving, gpu, ..."
    echo "环境: dev, staging, prod"
    exit 1
fi

MODULE="$1"
ENVIRONMENT="$2"
VERSION="${3:-latest}"

# 加载环境变量
ENV_FILE="$PROJECT_ROOT/environments/$ENVIRONMENT/.env"
if [ -f "$ENV_FILE" ]; then
    set -a; source "$ENV_FILE"; set +a
    log_ok "已加载环境: $ENVIRONMENT"
fi

# 模块路径检查
MODULE_DIR="$PROJECT_ROOT/$MODULE"
if [ ! -f "$MODULE_DIR/deploy/docker-compose.yml" ]; then
    log_error "模块 $MODULE 的部署配置不存在"
    exit 1
fi

log_info "部署 $MODULE@$VERSION → $ENVIRONMENT"

# 执行部署
docker compose \
    -f "$MODULE_DIR/deploy/docker-compose.yml" \
    -p "aiw-$MODULE" \
    up -d

# 健康检查
if [ -f "$MODULE_DIR/tests/smoke-test.sh" ]; then
    log_info "执行模块冒烟测试..."
    bash "$MODULE_DIR/tests/smoke-test.sh"
fi

log_ok "部署完成: $MODULE → $ENVIRONMENT"
