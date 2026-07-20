#!/usr/bin/env bash
set -euo pipefail

echo "Updating package metadata..."
apt update

echo "Installing available upgrades..."
apt upgrade -y

echo "Checking failed services..."
systemctl --failed || true
