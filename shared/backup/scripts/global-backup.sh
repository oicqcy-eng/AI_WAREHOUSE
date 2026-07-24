#!/bin/bash
# 全局备份脚本 — 调用各模块备份
set -euo pipefail

BACKUP_DIR="${BACKUP_DIR:-/data/backup}"
DATE=$(date +%Y%m%d_%H%M%S)
LOG="/var/log/backup_$DATE.log"

log() { echo "[$(date '+%H:%M:%S')] $1" | tee -a "$LOG"; }

log "=== 全局备份开始 ==="

# 数据库备份
log "备份 PostgreSQL..."
PGPASSWORD="${PGPASSWORD:-}" pg_dump -h localhost -U app_user -d ai_warehouse \
  --format=custom --compress=9 -f "$BACKUP_DIR/postgresql/${DATE}.sql.gz"

# 清理旧备份 (保留7天)
find "$BACKUP_DIR/postgresql/" -name "*.sql.gz" -mtime +7 -delete

log "=== 全局备份完成 ==="
