#!/bin/bash
# ============================================
# AI-WAREHOUSE — SSL 证书自动续期脚本
# ============================================
set -euo pipefail

DOMAINS=("api.ai-warehouse.local" "grafana.ai-warehouse.local")
CERT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LETSENCRYPT_DIR="/etc/letsencrypt/live"

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"; }

renew_cert() {
    local domain=$1
    log "正在续期证书: $domain"

    # Let's Encrypt 续期
    certbot renew --cert-name "$domain" --non-interactive --quiet

    # 复制新证书到仓库目录
    if [ -d "$LETSENCRYPT_DIR/$domain" ]; then
        cp "$LETSENCRYPT_DIR/$domain/fullchain.pem" "$CERT_DIR/certs/${domain}.crt"
        cp "$LETSENCRYPT_DIR/$domain/privkey.pem" "$CERT_DIR/private/${domain}.key"
        log "证书已更新: $domain"
    else
        log "警告: $domain 未找到 Let's Encrypt 证书"
    fi
}

reload_services() {
    log "重新加载服务..."

    # Nginx 重新加载
    if docker ps --format '{{.Names}}' | grep -q "ai-warehouse-nginx"; then
        docker exec ai-warehouse-nginx nginx -s reload
        log "Nginx 已重新加载"
    fi
}

check_expiry() {
    local cert_file="$CERT_DIR/certs/$1.crt"
    if [ -f "$cert_file" ]; then
        local expiry=$(openssl x509 -in "$cert_file" -noout -enddate | cut -d= -f2)
        local days_left=$(openssl x509 -in "$cert_file" -noout -checkend $((86400 * 30)) && echo ">=30" || echo "<30")
        log "$1 过期时间: $expiry ($days_left 天)"
    fi
}

# ── 主流程 ──
main() {
    log "===== SSL 证书检查与续期 ====="

    for domain in "${DOMAINS[@]}"; do
        check_expiry "$domain"
    done

    # 检查是否需要续期（30天内过期才续期）
    for domain in "${DOMAINS[@]}"; do
        local cert="$CERT_DIR/certs/${domain}.crt"
        if [ -f "$cert" ]; then
            if ! openssl x509 -in "$cert" -checkend $((86400 * 30)) > /dev/null; then
                renew_cert "$domain"
            else
                log "$domain 证书仍然有效"
            fi
        fi
    done

    reload_services
    log "===== SSL 续期完成 ====="
}

main
