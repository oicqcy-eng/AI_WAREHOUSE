#!/bin/bash
set -euo pipefail

CERT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOMAINS=("api.ai-warehouse.local")

renew_cert() {
    local domain=$1
    certbot renew --cert-name "$domain" --non-interactive --quiet
    cp "/etc/letsencrypt/live/$domain/fullchain.pem" "$CERT_DIR/certs/${domain}.crt"
    cp "/etc/letsencrypt/live/$domain/privkey.pem" "$CERT_DIR/private/${domain}.key"
    echo "[$(date)] 证书已更新: $domain"
}

reload_services() {
    docker exec ai-warehouse-nginx nginx -s reload 2>/dev/null || echo "Nginx 不可用"
}

# 检查 30 天内过期则续期
for domain in "${DOMAINS[@]}"; do
    cert="$CERT_DIR/certs/${domain}.crt"
    if [ -f "$cert" ] && ! openssl x509 -in "$cert" -checkend $((86400 * 30)) >/dev/null; then
        renew_cert "$domain"
    fi
done
reload_services
