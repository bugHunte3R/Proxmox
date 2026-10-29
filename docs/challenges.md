# Incidents and Lessons Learned

## 1. Guest address reset broke the tunnel

Container addresses changed; Cloudflare routes still pointed to the old ones and the public sites went down.

**Fix:** static addresses re-applied, tunnel origins checked one by one.
**Lesson:** every tunnel origin gets a static address and is documented privately.

## 2. Cloudflare Error 1033 / unstable connector

The private cloud returned Cloudflare error 1033 (tunnel not reachable).

**Fix:** forced HTTP/2 transport in the systemd unit, reduced the number of published services.
**Lesson:** troubleshoot the connector (edge side) and the origin (LAN side) separately.

## 3. Proxmox VE 8 → 9 major upgrade

Ran `pve8to9 --full` first, then upgraded both nodes to PVE 9 / Debian 13, one node at a time.

**Lesson:** keep quorum during the upgrade, keep the previous kernel as a boot fallback, and re-check scheduled jobs afterwards.

## 4. Nextcloud health warnings

Admin overview showed missing database indices, an old PHP version, wrong reverse-proxy detection and noisy logs; the enterprise repository blocked `apt` on the node.

**Fix, after a VM snapshot:** no-subscription repository, missing indices added, APCu for CLI, trusted proxy, log level tuned, system and database updates, PHP upgrade (old version kept for rollback), integrity check fixed. Health checks are now clean.
**Lesson:** "the site loads" is not "the app is healthy".

## 5. `php: command not found` when running `occ`

The command was run in the wrong container.
**Lesson:** confirm the host first (`hostnamectl`, `ip -br a`).

## 6. Long jobs killed inside the VM

Upgrading `qemu-guest-agent` killed commands started through it.
**Fix:** run long jobs with `systemd-run` inside the VM.

## 7. Raspberry Pi as a gateway

The Pi shared Wi-Fi to Ethernet with NetworkManager + nftables NAT. It worked, but every change risked cutting access to the cluster.
**Fix:** replaced by a dedicated router keeping the same gateway address.

## 8. Slow start after a power cut

Guests start sequentially; the most important site came back several minutes after power-on.
**Fix:** boot order set so it starts first; containers use `restart: unless-stopped`.

## 9. Disk pressure on the staging container

Each release build left several GB of Docker build cache.
**Fix:** periodic `docker builder prune` and removal of old rollback images after validation.

## 10. Missed scheduled backups

A monthly backup job did not run because the nodes were powered off at the scheduled time.
**Fix:** manual backup run, schedule review.
**Lesson:** verify backup tasks after every outage, not only the job definition.

## 11. VPN: handshake ≠ routing

A successful WireGuard handshake did not mean traffic reached the LAN — NAT/forwarding and `AllowedIPs` also had to be right.
**Lesson:** test handshake, then routing, then DNS, separately.
