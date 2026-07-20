#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="/var/backups/example"
DATE="$(date +%F-%H%M%S)"

mkdir -p "$BACKUP_DIR"

echo "Creating sanitized example backup..."
tar -czf "$BACKUP_DIR/config-$DATE.tar.gz" /etc/example 2>/dev/null || true

echo "Backup example completed."
