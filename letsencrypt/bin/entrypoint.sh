#!/bin/bash

set -e

STDOUT=/proc/1/fd/1

# Wait for HAproxy to start before updating certificates on startup.
(sleep 60; update-certs.sh > ${STDOUT}) &

exec "$@"
