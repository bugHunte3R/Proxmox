# Infrastructure Inventory

## Virtualization Hosts

| Name | Role | Operating System | Documentation Hostname |
|---|---|---|---|
| Node 1 | Proxmox cluster node | Proxmox VE | `pve-node-01` |
| Node 2 | Proxmox cluster node | Proxmox VE | `pve-node-02` |

## Virtual Workloads

| Name | Type | Role | Operating System |
|---|---|---|---|
| Docker Host | LXC | Docker application platform | Debian |
| Tunnel Connector | LXC | Cloudflare Tunnel | Debian |
| VPN Gateway | LXC | WireGuard VPN | Debian |
| Private Cloud | LXC | Nextcloud | Debian |

## Network Equipment

| Component | Role |
|---|---|
| ISP Router | Internet gateway, NAT and firewall |
| Managed Switch | Wired connectivity and network distribution |
| Raspberry Pi | Network utility services |
| Ethernet Links | Physical connectivity between hosts and switch |

## Applications

| Application | Deployment |
|---|---|
| React Portfolio | Docker |
| UniFi Network Application | Docker |
| Nextcloud | Dedicated LXC |
| Cloudflare Connector | Dedicated LXC |
| WireGuard | Dedicated LXC |

## Resource Planning Principles

- Infrastructure services receive predictable resources
- Application containers can be adjusted independently
- Storage-intensive services remain isolated
- Network services are kept lightweight
- Backup planning is considered before expanding a workload

## Information Intentionally Excluded

- Hardware serial numbers
- MAC addresses
- Exact CPU and storage identifiers
- Public IP addresses
- Internal production addresses
- Proxmox fingerprints
- Container IDs
- Router identifiers
- Backup target addresses
