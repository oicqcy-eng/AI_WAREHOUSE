#!/bin/bash
# AI-WAREHOUSE — 模块部署脚本
# 用法: ./deploy.sh <module> <environment> [version]
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

if [ $# -lt 2 ]; then
  echo "用法: $0 <module> <environment> [version]"
  echo "模块: master-data, barcode, production, work-order, scheduling, process, andon, quality, equipment, material, warehouse, mould, energy, traceability, system, document, reporting, kanban, iiot, ai-serving, gpu, vector-db, training"
  echo "环境: dev, staging, prod"
  exit 1
fi

MODULE="$1"; ENVIRONMENT="$2"; VERSION="${3:-latest}"

ENV_FILE="$PROJECT_ROOT/environments/$ENVIRONMENT/.env"
[ -f "$ENV_FILE" ] && { set -a; source "$ENV_FILE"; set +a; }

MODULE_DIR="$PROJECT_ROOT/$MODULE"
if [ ! -f "$MODULE_DIR/deploy/docker-compose.yml" ]; then
  echo "错误: 模块 $MODULE 的部署配置不存在"; exit 1
fi

echo "部署 $MODULE@$VERSION → $ENVIRONMENT"
docker compose -f "$MODULE_DIR/deploy/docker-compose.yml" -p "aiw-$MODULE" up -d

if [ -f "$MODULE_DIR/tests/smoke-test.sh" ]; then
  echo "执行模块冒烟测试..."; bash "$MODULE_DIR/tests/smoke-test.sh"
fi
echo "完成: $MODULE → $ENVIRONMENT"
