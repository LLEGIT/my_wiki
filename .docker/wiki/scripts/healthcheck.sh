#!/bin/sh
# Simple healthcheck script for Wiki.js

# Check if Wiki.js is responding on port 3000
if curl -f http://localhost:3000/healthz >/dev/null 2>&1; then
    exit 0
else
    # Fallback: check if the process is running
    if pgrep -f "node" >/dev/null 2>&1; then
        exit 0
    else
        exit 1
    fi
fi
