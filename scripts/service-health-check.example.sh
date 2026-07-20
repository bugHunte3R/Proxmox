#!/usr/bin/env bash
set -euo pipefail

echo "=== System ==="
uptime
free -h
df -h

echo
echo "=== Failed services ==="
systemctl --failed || true

if command -v docker >/dev/null 2>&1; then
  echo
  echo "=== Docker containers ==="
  docker ps
fi
