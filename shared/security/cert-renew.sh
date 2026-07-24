#!/bin/bash
set -euo pipefail
CERT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOMAINS=("api.ai-warehouse.local")
for domain in "${DOMAINS[@]}"; do
  cert="$CERT_DIR/${domain}.crt"
  if [ -f "$cert" ] && ! openssl x509 -in "$cert" -checkend $((86400*30)) >/dev/null; then
    certbot renew --cert-name "$domain" --non-interactive --quiet
    cp "/etc/letsencrypt/live/$domain/fullchain.pem" "$CERT_DIR/${domain}.crt"
    cp "/etc/letsencrypt/live/$domain/privkey.pem" "$CERT_DIR/${domain}.key"
  fi
done
docker exec aiw-nginx nginx -s reload 2>/dev/null || true
