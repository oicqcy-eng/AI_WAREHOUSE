#!/bin/bash
# AI-WAREHOUSE — 模块部署脚本
# 用法: ./deploy.sh <group/module> <environment>
# 示例: ./deploy.sh manufacturing/quality dev
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

if [ $# -lt 2 ]; then
  echo "用法: $0 <group/module> <environment>"
  echo "示例: $0 manufacturing/quality dev"
  echo "可用: base/system, base/master-data, manufacturing/quality, manufacturing/equipment, operations/kanban, ai/serving, ..."
  exit 1
fi

MODULE_PATH="$1"; ENVIRONMENT="$2"

ENV_FILE="$PROJECT_ROOT/environments/$ENVIRONMENT/.env"
[ -f "$ENV_FILE" ] && { set -a; source "$ENV_FILE"; set +a; }

MODULE_DIR="$PROJECT_ROOT/$MODULE_PATH"
if [ ! -f "$MODULE_DIR/deploy/docker-compose.yml" ]; then
  echo "错误: $MODULE_PATH 的部署配置不存在"; exit 1
fi

echo "部署 $MODULE_PATH → $ENVIRONMENT"
docker compose -f "$MODULE_DIR/deploy/docker-compose.yml" -p "aiw-$(basename $MODULE_PATH)" up -d

[ -f "$MODULE_DIR/tests/smoke-test.sh" ] && bash "$MODULE_DIR/tests/smoke-test.sh"
echo "完成: $MODULE_PATH"
