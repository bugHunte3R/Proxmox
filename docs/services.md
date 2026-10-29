# Services

## Inventory

| Service | Where | Access |
|---|---|---|
| Nextcloud | VM on Node 1 | Public via tunnel |
| React portfolio | Docker host | Public via tunnel |
| Portfolio e-mail API (Node.js) | Docker host, systemd service | Internal, proxied by the portfolio's Nginx |
| InvoiceShelf + PostgreSQL | Docker host, Docker Compose | Private |
| Portainer CE | Docker host | Private |
| Cloudflare connector | Dedicated LXC | Outbound only |
| UniFi OS Server | Dedicated LXC | Private |
| Client staging (Next.js + PostgreSQL + Caddy) | Dedicated LXC, Docker Compose | Public via tunnel |
| Proxmox Backup Server | Dedicated machine | Private |

## Nextcloud

```text
Debian
├── Apache + mod_php
├── MariaDB
├── Redis (file locking + cache) and APCu (local cache)
├── Nextcloud data on a dedicated virtual disk
└── qemu-guest-agent
```

Administration is done from the Proxmox node through the guest agent; long jobs run through `systemd-run` so they survive an agent restart.

## Docker host

Portfolio build:

```text
React source ──> Node.js build stage (npm install, npm run build)
             ──> Nginx serves the static build, SPA fallback, /api/ → Node e-mail API
             ──> Cloudflare Tunnel
```

Other Compose projects tested on this host and kept for later: Actual Budget, Firefly III, Nginx Proxy Manager, Prometheus + Grafana + Proxmox exporter, and a Telegram job-alert bot.

## Cloudflare connector

Native package + systemd unit (not Docker), HTTP/2 transport, remotely managed tunnel. The token is never stored in this repository.

## UniFi OS Server

Deployed in an LXC with a Proxmox helper script. Previously tested on the Raspberry Pi, moved to Proxmox so it is backed up with everything else.

## Client staging

A freelance project: a marketplace web application tested by the client on my infrastructure.

```text
Ubuntu LXC
└── Docker Compose
    ├── app    Next.js standalone build
    ├── db     PostgreSQL
    └── caddy  reverse proxy
```

Release procedure (scripted):

1. Code shipped as a `git bundle` — the server holds no Git credentials.
2. Application backup: database dump, uploads archive, current version, image tagged for instant rollback.
3. New image built while the old version keeps serving.
4. Short maintenance page during database migrations and container swap.
5. Health checks, then the site reopens.
