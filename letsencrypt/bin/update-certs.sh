#!/bin/bash

set -e

# The certbot standalone plugin returns 503 errors. Perhaps because some time
# is needed after starting before HAproxy can detect it. So run our own web
# server and use the webroot plugin.
mkdir -p /opt/www
(cd /opt/www && python -m SimpleHTTPServer 80) &

# Wait for HAproxy to start before updating certificates on startup.
sleep 60

while true
do
    # Certificates are separated by semi-colon (;). Domains on each certificate are
    # separated by comma (,).
    CERTS=(${DOMAINS//;/ })

    # Create or renew certificates.
    for DOMAINS in "${CERTS[@]}"; do
        echo "Renewing domain(s): ${DOMAINS} ..."
        certbot certonly \
            --agree-tos \
            --domains "$DOMAINS" \
            --email "$EMAIL" \
            --expand \
            --noninteractive \
            --webroot \
            --webroot-path /opt/www \
            ${OPTIONS} \
            || true
    done

    # Check if any certificates should be renewed daily
    sleep 86400
done
