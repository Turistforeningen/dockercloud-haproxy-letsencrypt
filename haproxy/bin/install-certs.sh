#!/bin/bash

set -e

mkdir -p "$CERT_FOLDER"

# Install combined certificates for HAproxy.
if [[ -n "$(ls -A $LIVE_CERT_FOLDER)" ]]; then
    COUNT=0
    for DIR in "$LIVE_CERT_FOLDER"/*; do
        cat "$DIR/privkey.pem" "$DIR/fullchain.pem" > "$CERT_FOLDER/cert$COUNT.pem"
        (( COUNT += 1 ))
    done
fi
