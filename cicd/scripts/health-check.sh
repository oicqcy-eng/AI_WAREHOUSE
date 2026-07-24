#!/bin/bash
# AI-WAREHOUSE — 全平台健康检查
set -euo pipefail
check_docker() { docker ps --format '{{.Names}}' 2>/dev/null | grep -qx "$1" && echo "  ✅ $1" || echo "  ❌ $1"; }
check_http() { curl -sf "$2" >/dev/null 2>&1 && echo "  ✅ $1" || echo "  ❌ $1"; }
echo "=== AI-WAREHOUSE 健康检查 $(date '+%Y-%m-%d %H:%M:%S') ==="
echo "--- 基础层 ---"
check_docker aiw-system; check_docker aiw-master-data
echo "--- 制造层 ---"
check_docker aiw-quality; check_docker aiw-equipment; check_docker aiw-warehouse
echo "--- AI层 ---"
check_docker aiw-vllm; check_docker aiw-gpu-exporter
echo "--- 基础设施 ---"
check_docker aiw-postgres; check_docker aiw-redis; check_docker aiw-prometheus; check_docker aiw-grafana
echo "--- HTTP端点 ---"
check_http "Quality" "http://localhost:8081/health"
check_http "Equipment" "http://localhost:8082/health"
check_http "System" "http://localhost:8086/health"
check_http "vLLM" "http://localhost:8000/health"
echo "--- GPU ---"
if command -v nvidia-smi &>/dev/null; then nvidia-smi --query-gpu=name,temperature.gpu,memory.used,memory.total --format=csv; else echo "  未检测到 GPU"; fi
echo "=== 完成 ==="
