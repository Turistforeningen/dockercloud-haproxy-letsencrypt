#!/bin/bash

set -e

STDOUT=/proc/1/fd/1

# The certbot standalone plugin returns 503 errors. Perhaps because some time
# is needed after starting before HAproxy can detect it. So run our own web
# server and use the webroot plugin.
if [[ -z "$(ps | grep python | grep -v grep)" ]]; then
    mkdir -p /opt/www
    (cd /opt/www && python -m SimpleHTTPServer 80) &
    sleep 1
fi

# Certificates are separated by semi-colon (;). Domains on each certificate are
# separated by comma (,).
CERTS=(${DOMAINS//;/ })

# Create or renew certificates.
for DOMAINS in "${CERTS[@]}"; do
    certbot certonly \
        --agree-tos \
        --domains "$DOMAINS" \
        --email "$EMAIL" \
        --expand \
        --noninteractive \
        --webroot \
        --webroot-path /opt/www \
        ${OPTIONS} \
        > ${STDOUT} \
        || true
done
