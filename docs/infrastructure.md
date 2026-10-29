# Infrastructure

## Proxmox VE nodes

| | Node 1 | Node 2 |
|---|---|---|
| Hardware | Small-form-factor desktop | Small-form-factor desktop |
| RAM | 16 GB | 16 GB |
| Disk | 1 TB SSD | 1 TB HDD |
| OS | Proxmox VE 9 (Debian 13) | Proxmox VE 9 (Debian 13) |
| Network | One NIC bridged into a Linux bridge | One NIC bridged into a Linux bridge |
| Time | chrony, synchronized | chrony, synchronized |

## Cluster

| Item | Value |
|---|---|
| Members | 2 nodes |
| Transport | Corosync (knet) on the LAN |
| Storage | Local + LVM-thin per node, Proxmox Backup Server shared by both |

## Proxmox Backup Server

Standalone machine, not a cluster member, with a dedicated deduplicated datastore used by both nodes.

## Workloads

| Workload | Type | Node | Sizing | Notes |
|---|---|---|---|---|
| Nextcloud | KVM VM | Node 1 | 2 vCPU, 12 GB RAM, large data disk | QEMU guest agent, starts on boot |
| Docker host | Unprivileged LXC, nesting | Node 2 | 1 vCPU, 3 GB RAM | Static address |
| Tunnel connector | Unprivileged LXC | Node 2 | 1 vCPU, 512 MB RAM | Static address |
| Network controller | LXC, nesting | Node 2 | 2 vCPU, 4 GB RAM | UniFi OS Server |
| Client staging | Unprivileged LXC, nesting | Node 2 | 2 vCPU, 4 GB RAM | Static address, first to boot |

Earlier workloads (a WireGuard VPN container, a first Nextcloud container, test VMs) were retired; their last backups are kept on the backup server.

## Network equipment

| Device | Role |
|---|---|
| Router | Gateway, DHCP, DNS |
| Managed switch | Wired distribution |
| Raspberry Pi | Former gateway (NetworkManager sharing + nftables NAT), replaced by the router |
