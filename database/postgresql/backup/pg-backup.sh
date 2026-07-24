#!/bin/bash
# ============================================
# AI-WAREHOUSE — PostgreSQL 备份脚本
# 用法: ./pg-backup.sh [database_name] [backup_dir]
# 定时: 0 2 * * * /path/to/pg-backup.sh >> /var/log/backup.log 2>&1
# ============================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

DB_NAME="${1:-ai_warehouse}"
BACKUP_DIR="${2:-$SCRIPT_DIR}"
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_${TIMESTAMP}.sql.gz"
RETENTION_DAYS=${PG_BACKUP_RETENTION:-7}

# ── 加载环境变量 ──
ENV_FILE="$PROJECT_ROOT/environments/${ENV:-dev}/.env"
if [ -f "$ENV_FILE" ]; then
    set -a; source "$ENV_FILE"; set +a
fi

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"; }

# ── 备份前检查 ──
log "开始备份数据库: $DB_NAME"
mkdir -p "$BACKUP_DIR"

if ! command -v pg_dump &>/dev/null; then
    log "错误: pg_dump 未安装"
    exit 1
fi

# ── 执行备份 ──
PGPASSWORD="${PGPASSWORD:-${POSTGRES_PASSWORD:-}}" \
pg_dump \
    -h "${PGHOST:-localhost}" \
    -p "${PGPORT:-5432}" \
    -U "${PGUSER:-app_user}" \
    -d "$DB_NAME" \
    --verbose \
    --format=custom \
    --compress=9 \
    --file="${BACKUP_FILE%.gz}" \
    --no-owner \
    --no-privileges

if [ $? -eq 0 ]; then
    gzip "${BACKUP_FILE%.gz}"
    log "备份完成: $BACKUP_FILE ($(ls -lh "$BACKUP_FILE" | awk '{print $5}'))"
else
    log "备份失败: $DB_NAME"
    exit 1
fi

# ── 清理旧备份 ──
find "$BACKUP_DIR" -name "${DB_NAME}_*.sql.gz" -mtime +$RETENTION_DAYS -delete
log "已清理 $RETENTION_DAYS 天前的旧备份"

# ── 验证备份 ──
log "备份文件校验:"
gunzip -t "$BACKUP_FILE" && log "校验通过 ✅" || log "校验失败 ❌"
