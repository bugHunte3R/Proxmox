# Architecture

## Design goals

- Run real services (private cloud, portfolio, client staging) on low-cost, low-power hardware
- Keep a fixed addressing plan so static addresses and tunnel routes never break
- Publish web apps **without opening inbound ports** (outbound Cloudflare Tunnel only)
- Keep infrastructure roles separate (tunnel, network controller, apps, storage) to simplify recovery
- Back every guest up to a machine that is **not** part of the cluster

## Physical layer

| Device | Role |
|---|---|
| Node 1 (small-form-factor desktop, SSD) | Proxmox VE node |
| Node 2 (small-form-factor desktop, HDD) | Proxmox VE node |
| Backup server | Proxmox Backup Server |
| Router | LAN gateway, DHCP, DNS |
| Managed switch | Wired distribution |

## Cluster layer

```text
Proxmox VE cluster (Corosync, 2 votes)
├── Node 1
│   └── VM   Nextcloud
└── Node 2
    ├── LXC  Docker host
    ├── LXC  Tunnel connector
    ├── LXC  Network controller
    └── LXC  Client staging

Proxmox Backup Server (outside the cluster)
```

**Placement logic**

- Node 1 has the SSD and the stronger CPU → it gets the I/O-heavy Nextcloud VM.
- Node 2 has the larger HDD → it gets the small, mostly idle LXC services.
- Storage is local LVM-thin on each node; shared storage and HA are on the roadmap.

## Why a VM for Nextcloud and LXC for the rest

| Choice | Reason |
|---|---|
| Nextcloud in a **KVM VM** | Own kernel, full isolation for personal data, QEMU guest agent for consistent snapshots, independent upgrades |
| Services in **unprivileged LXC** | Minimal overhead on small CPUs |
| Docker **inside** LXC | Keep Compose-based apps grouped and snapshot them as one unit |

## Data flows

### Public web

```text
Browser ──HTTPS──> Cloudflare edge ──(tunnel opened outbound)──> Tunnel connector ──> internal application
```

### Administration

```text
Admin workstation (private network only) ──> Proxmox / PBS web interfaces, SSH with keys
```

### Backups

```text
Node 1 / Node 2  ──vzdump (snapshot mode)──>  Proxmox Backup Server  (deduplicated)
```

## Design decisions and trade-offs

- **Two nodes** → simple and cheap; a quorum device is planned to tolerate one node failure.
- **Backup server outside the cluster** → backups survive a cluster failure and can be restored to either node.
- **Static addresses for every tunnel origin** → an address reset once broke the tunnel routes; never again.
