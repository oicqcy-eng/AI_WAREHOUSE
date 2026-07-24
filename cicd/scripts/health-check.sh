#!/bin/bash
# AI-WAREHOUSE — 全平台健康检查
set -euo pipefail

check_docker() { docker ps --format '{{.Names}}' 2>/dev/null | grep -qx "$1" && echo "  ✅ $1" || echo "  ❌ $1"; }
check_http() { curl -sf "$2" >/dev/null 2>&1 && echo "  ✅ $1 ($2)" || echo "  ❌ $1 ($2)"; }

echo "=============================="
echo " AI-WAREHOUSE 健康检查"
echo " $(date '+%Y-%m-%d %H:%M:%S')"
echo "=============================="
echo ""
echo "--- 容器状态 ---"
for c in aiw-postgres aiw-redis aiw-prometheus aiw-grafana aiw-master-data aiw-quality aiw-equipment aiw-system aiw-vllm aiw-gpu-exporter; do
  check_docker "$c" || true
done
echo ""
echo "--- HTTP 端点 ---"
check_http "Master Data" "http://localhost:8071/health" || true
check_http "Quality" "http://localhost:8081/health" || true
check_http "Equipment" "http://localhost:8082/health" || true
check_http "System" "http://localhost:8086/health" || true
check_http "vLLM" "http://localhost:8000/health" || true
echo ""
echo "--- GPU ---"
if command -v nvidia-smi &>/dev/null; then
  nvidia-smi --query-gpu=name,temperature.gpu,memory.used,memory.total --format=csv
else
  echo "  未检测到 GPU"
fi
echo ""
echo "=============================="
echo " 检查完成"
echo "=============================="
