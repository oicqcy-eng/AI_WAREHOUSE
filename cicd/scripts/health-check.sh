#!/bin/bash
# ============================================
# AI-WAREHOUSE — 系统健康检查
# 用法: ./health-check.sh [--json]
# ============================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

JSON_MODE=false
if [ "${1:-}" = "--json" ]; then
    JSON_MODE=true
fi

check_port() {
    local service=$1 port=$2
    if ss -tlnp 2>/dev/null | grep -q ":$port "; then
        echo "$service: ✅ 运行中 (端口 $port)"
        return 0
    elif nc -z localhost "$port" 2>/dev/null; then
        echo "$service: ✅ 运行中 (端口 $port)"
        return 0
    else
        echo "$service: ❌ 未运行 (端口 $port)"
        return 1
    fi
}

check_docker() {
    local container=$1
    if docker ps --format '{{.Names}}' 2>/dev/null | grep -qx "$container"; then
        local status=$(docker inspect "$container" --format '{{.State.Status}}')
        echo "$container: ✅ $status"
        return 0
    else
        echo "$container: ❌ 未运行"
        return 1
    fi
}

check_gpu() {
    if command -v nvidia-smi &>/dev/null; then
        local gpu_count=$(nvidia-smi --query-gpu=name --format=csv,noheader | wc -l)
        echo "GPU: ✅ $gpu_count 块可用"
        nvidia-smi --query-gpu=name,temperature.gpu,memory.used,memory.total --format=csv,noheader | while IFS=, read -r name temp mem_used mem_total; do
            echo "  ├─ $name | 温度: ${temp}°C | 显存: ${mem_used}/${mem_total}"
        done
        return 0
    else
        echo "GPU: ⚠️ 未检测到 NVIDIA 驱动"
        return 1
    fi
}

check_disk() {
    echo "磁盘使用:"
    df -h / | tail -1 | awk '{print "  ├─ 总空间: " $2 " / 已用: " $3 " (" $5 ") / 可用: " $4}'
}

check_memory() {
    echo "内存使用:"
    free -h | grep Mem | awk '{print "  ├─ 总内存: " $2 " / 已用: " $3 " / 可用: " $4}'
}

main() {
    echo "=============================="
    echo " AI-WAREHOUSE 健康检查"
    echo " 时间: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "=============================="
    echo ""

    echo "--- 服务状态 ---"
    check_docker ai-warehouse-pg       && PG_OK=true   || PG_OK=false
    check_docker ai-warehouse-redis    && RD_OK=true   || RD_OK=false
    check_docker ai-warehouse-milvus   || true
    check_docker ai-warehouse-vllm     || true
    check_docker ai-warehouse-prometheus || true
    check_docker ai-warehouse-grafana  || true
    echo ""

    echo "--- GPU 状态 ---"
    check_gpu
    echo ""

    echo "--- 资源状态 ---"
    check_disk
    check_memory
    echo ""

    echo "--- 端口监听 ---"
    check_port "PostgreSQL"     5432 || true
    check_port "Redis"         6379 || true
    check_port "Milvus"       19530 || true
    check_port "vLLM"         8000 || true
    check_port "Grafana"      3000 || true
    check_port "Prometheus"   9090 || true
    echo ""

    echo "=============================="
    if [ "$PG_OK" = false ] || [ "$RD_OK" = false ]; then
        echo " 结果: ⚠️  部分服务异常，请检查"
        exit 1
    else
        echo " 结果: ✅ 系统运行正常"
    fi
    echo "=============================="
}

main
