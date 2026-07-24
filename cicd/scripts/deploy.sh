#!/bin/bash
# ============================================
# AI-WAREHOUSE — 通用部署脚本
# 用法: ./deploy.sh <service> <environment> [version]
# 示例: ./deploy.sh vllm staging v2.1.0
# ============================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# ── 颜色 ──
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info()  { echo -e "${BLUE}[INFO]${NC}  $1"; }
log_ok()    { echo -e "${GREEN}[OK]${NC}   $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# ── 参数校验 ──
if [ $# -lt 2 ]; then
    echo "用法: $0 <service> <environment> [version]"
    echo "服务: vllm | triton | milvus | manufacturing | monitoring"
    echo "环境: dev | staging | prod"
    exit 1
fi

SERVICE="$1"
ENVIRONMENT="$2"
VERSION="${3:-latest}"

# ── 加载环境变量 ──
ENV_FILE="$PROJECT_ROOT/environments/$ENVIRONMENT/.env"
if [ ! -f "$ENV_FILE" ]; then
    log_warn "环境文件 $ENV_FILE 不存在，使用默认值"
else
    set -a
    source "$ENV_FILE"
    set +a
    log_ok "已加载环境: $ENVIRONMENT"
fi

# ── 部署前检查 ──
pre_deploy_check() {
    log_info "===== 部署前检查 ====="

    # Docker 检查
    if ! command -v docker &>/dev/null; then
        log_error "Docker 未安装"
        exit 1
    fi
    log_ok "Docker 可用: $(docker --version)"

    # 磁盘空间检查（低于 5GB 告警）
    AVAILABLE_GB=$(df / | awk 'NR==2 {print $4/1024/1024}')
    if (( $(echo "$AVAILABLE_GB < 5" | bc -l) )); then
        log_error "磁盘空间不足: ${AVAILABLE_GB}GB，需要至少 5GB"
        exit 1
    fi
    log_ok "磁盘空间充足: ${AVAILABLE_GB}GB"
}

# ── 部署 AI 服务 ──
deploy_ai_service() {
    local profile=""
    case "$SERVICE" in
        vllm)   profile="gpu";;
        triton) profile="gpu";;
        milvus) profile="";;
    esac

    log_info "正在部署 $SERVICE:$VERSION ($ENVIRONMENT)..."

    if [ -n "$profile" ]; then
        docker compose \
            -f "$PROJECT_ROOT/orchestration/docker/docker-compose.yml" \
            -f "$PROJECT_ROOT/orchestration/docker/docker-compose.ai.yml" \
            --profile "$profile" \
            up -d "$SERVICE"
    else
        docker compose \
            -f "$PROJECT_ROOT/orchestration/docker/docker-compose.yml" \
            -f "$PROJECT_ROOT/orchestration/docker/docker-compose.ai.yml" \
            up -d "$SERVICE"
    fi
}

# ── 部署监控服务 ──
deploy_monitoring() {
    docker compose \
        -f "$PROJECT_ROOT/orchestration/docker/docker-compose.yml" \
        -f "$PROJECT_ROOT/orchestration/docker/docker-compose.monitor.yml" \
        up -d "${@:-}"
}

# ── 健康检查 ──
health_check() {
    log_info "===== 健康检查 ====="

    case "$SERVICE" in
        vllm)
            sleep 10
            curl -sf http://localhost:8000/health || log_warn "vLLM 健康检查未通过（服务可能仍在启动）"
            ;;
        triton)
            sleep 5
            curl -sf http://localhost:8001/v2/health/ready || log_warn "Triton 健康检查未通过"
            ;;
        milvus)
            sleep 5
            curl -sf http://localhost:9091/health || log_warn "Milvus 健康检查未通过"
            ;;
        *)
            log_info "跳过健康检查（$SERVICE）"
            ;;
    esac
}

# ── 部署后记录 ──
post_deploy_record() {
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "$timestamp | $SERVICE | $VERSION | $ENVIRONMENT | ${USER:-deployer}" >> "$PROJECT_ROOT/docs/changelogs/deploy.log"
    log_ok "已记录部署日志"
}

# ============================================
# 主流程
# ============================================
main() {
    log_info "开始部署: $SERVICE@$VERSION → $ENVIRONMENT"

    pre_deploy_check

    case "$SERVICE" in
        vllm|triton|milvus)
            deploy_ai_service
            ;;
        manufacturing)
            log_info "制造服务部署（待实现）"
            ;;
        monitoring)
            deploy_monitoring
            ;;
        *)
            log_error "未知服务: $SERVICE"
            echo "可用服务: vllm, triton, milvus, manufacturing, monitoring"
            exit 1
            ;;
    esac

    health_check
    post_deploy_record

    log_ok "部署完成: $SERVICE@$VERSION → $ENVIRONMENT"
}

main
