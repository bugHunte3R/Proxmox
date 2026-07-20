# Services

## Service Inventory

| Service | Platform | Access Type | Purpose |
|---|---|---|---|
| Proxmox VE | Physical hosts | Private | Virtualization management |
| Docker | LXC | Private | Containerized applications |
| Portfolio | Docker | Public | Professional portfolio |
| UniFi Network Application | Docker | Private | Network management |
| Nextcloud | LXC | Selected public access | Private cloud |
| Cloudflare Tunnel | LXC | Outbound connector | Secure application publishing |
| WireGuard | LXC | VPN | Remote administration |
| Raspberry Pi Services | Physical device | Private | Network utilities |

## Portfolio

The portfolio is a React application deployed using Docker.

```text
Source code
   |
   v
Node.js build stage
   |
   v
Static production files
   |
   v
Nginx container
   |
   v
Cloudflare Tunnel
```

## Nextcloud

```text
Nextcloud
├── Apache
├── PHP
├── MariaDB
├── Redis
├── APCu
└── Persistent data
```

## UniFi Network Application

The UniFi application runs in Docker and manages compatible network equipment.

Its administrative interface is kept private.

## Cloudflare Tunnel

The connector establishes outbound connections. Production tunnel credentials and ingress rules are excluded.

## WireGuard

WireGuard provides encrypted remote access to private systems.

Only placeholder configurations are included in this repository.
