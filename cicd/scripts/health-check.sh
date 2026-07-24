#!/bin/bash
# ============================================
# AI-WAREHOUSE — 全平台健康检查
# 用法: ./health-check.sh [module]
# ============================================
set -euo pipefail

check_docker() {
    local container=$1
    if docker ps --format '{{.Names}}' 2>/dev/null | grep -qx "$container"; then
        local status=$(docker inspect "$container" --format '{{.State.Status}}')
        echo "  ✅ $container ($status)"
        return 0
    else
        echo "  ❌ $container (未运行)"
        return 1
    fi
}

check_http() {
    local name=$1 url=$2
    if curl -sf "$url" >/dev/null 2>&1; then
        echo "  ✅ $name (${url})"
    else
        echo "  ❌ $name (${url})"
    fi
}

check_gpu() {
    if command -v nvidia-smi &>/dev/null; then
        local count=$(nvidia-smi --query-gpu=name --format=csv,noheader | wc -l)
        echo "  ✅ GPU: $count 块可用"
        nvidia-smi --query-gpu=name,temperature.gpu,memory.used,memory.total --format=csv,noheader
    else
        echo "  ⚠️  未检测到 GPU"
    fi
}

echo "=============================="
echo " AI-WAREHOUSE 健康检查"
echo " $(date '+%Y-%m-%d %H:%M:%S')"
echo "=============================="
echo ""

echo "--- 容器状态 ---"
check_docker aiw-quality || true
check_docker aiw-equipment || true
check_docker aiw-system || true
check_docker aiw-vllm || true
check_docker aiw-gpu-exporter || true
echo ""

echo "--- HTTP 端点 ---"
check_http "质量模块" "http://localhost:8081/health" || true
check_http "设备模块" "http://localhost:8082/health" || true
check_http "系统模块" "http://localhost:8083/health" || true
check_http "vLLM" "http://localhost:8000/health" || true
check_http "GPU Exporter" "http://localhost:9400/metrics" || true
echo ""

echo "--- GPU 状态 ---"
check_gpu || true
echo ""

echo "=============================="
echo " 检查完成"
echo "=============================="
