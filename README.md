# Proxmox Homelab

Professional documentation of a self-hosted Proxmox VE homelab.

## Technologies

- Proxmox VE
- Debian Linux
- LXC
- Docker & Docker Compose
- Cloudflare Tunnel
- WireGuard
- Nextcloud
- UniFi Network Application
- Nginx
- Apache
- MariaDB
- Redis
- Raspberry Pi

## Architecture

```text
Internet
   |
Router / Firewall
   |
Managed Switch
   |
+-------------------------+
|  Proxmox VE Cluster     |
|-------------------------|
| Node 1                  |
|  - Cloudflare Tunnel    |
|  - WireGuard            |
|                         |
| Node 2                  |
|  - Docker Host          |
|  - Nextcloud            |
+-------------------------+
```

This repository intentionally excludes passwords, API keys, domains, IP addresses, tunnel IDs and other sensitive information.
