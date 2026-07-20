# Architecture

## Design Objectives

The homelab was designed to:

- Provide a practical environment for infrastructure administration
- Separate services according to their role
- Support both private and selected public services
- Allow secure remote administration
- Simplify backup and restoration
- Provide hands-on experience with virtualization and containers
- Limit direct Internet exposure

## Proxmox Cluster

The virtualization layer consists of two Proxmox VE nodes.

```text
Proxmox Cluster
├── Node 1
│   ├── Cloudflare Tunnel LXC
│   ├── WireGuard VPN LXC
│   └── Infrastructure workloads
└── Node 2
    ├── Docker LXC
    ├── Nextcloud LXC
    └── Application workloads
```

Workload placement can change depending on maintenance requirements and available resources.

## Workload Separation

### Docker Host

A dedicated Debian LXC container hosts containerized applications.

Responsibilities:

- Docker Engine
- Docker Compose
- React portfolio
- UniFi Network Application
- Additional web applications
- Persistent Docker volumes

### Cloudflare Connector

A dedicated LXC container runs `cloudflared`.

Responsibilities:

- Establish outbound connections to Cloudflare
- Route selected public hostnames to internal applications
- Avoid exposing application ports directly on the router
- Keep tunnel configuration separate from application containers

### WireGuard Server

A dedicated LXC container provides private remote access.

Responsibilities:

- Authenticate remote clients
- Route authorized traffic to internal systems
- Provide encrypted administration
- Separate private access from public web access

### Nextcloud Server

Nextcloud runs inside a dedicated LXC container.

Main components:

- Apache
- PHP
- MariaDB
- Redis
- APCu
- Nextcloud application
- Persistent application data

## Physical Infrastructure

The physical environment includes:

- Two virtualization hosts
- One managed network switch
- One Raspberry Pi
- One ISP router
- Ethernet connectivity
- Local storage
- External or secondary backup storage

Exact models, capacities and serial numbers are intentionally excluded.

## Data Flow

### Public Application Flow

```text
User
  |
  v
Cloudflare
  |
  v
Cloudflare Tunnel
  |
  v
Authorized internal application
```

### Private Administration Flow

```text
Administrator
  |
  v
WireGuard VPN
  |
  v
Private management network
  |
  v
Proxmox, Linux and application interfaces
```

### Internal User Flow

```text
Local device
  |
  v
Managed switch
  |
  v
Internal service
```

## Design Decisions

### Dedicated Infrastructure Containers

Security-related services such as the VPN server and tunnel connector are isolated from general workloads.

### Limited Public Exposure

Only selected web applications are published. Infrastructure-management interfaces remain private.

### Documentation Placeholders

All addressing values use documentation-only networks and generic hostnames.

### Recovery-Oriented Design

Applications, databases, configurations and virtualized workloads can be backed up independently.
