#!/bin/bash

set -e

# Wait for HAproxy to start before updating certificates on startup.
(sleep 60; update-certs.sh) &

exec "$@"
