# Backup Strategy

## Layers in place

| Layer | Tool | Scope |
|---|---|---|
| 1. Guest backups | vzdump → Proxmox Backup Server | every VM and container |
| 2. Snapshots before changes | `qm snapshot` / `pct snapshot` | the guest being changed |
| 3. Application backups | database dump, uploads archive, tagged Docker image | client staging |
| 4. Off-box copies | copy of application backups to a workstation | client staging |

## Proxmox Backup Server

- Dedicated machine outside the cluster, shared by both nodes
- Deduplicated chunk store: several full backups of a large Nextcloud disk fit in a fraction of its size
- Scheduled job for all guests, snapshot mode (no downtime), retention policy, e-mail notification
- Manual backups before risky work

## Snapshots as rollback points

A snapshot is taken before every upgrade or configuration change (e.g. before the Nextcloud PHP/database work, before each staging release). Rollback is one command. Snapshots are deleted once the change is validated — they are not backups.

## Recovery priorities

1. Tunnel connector — restores all public access
2. Nextcloud — personal data
3. Client staging
4. Docker host
5. Network controller

## Lesson learned

A scheduled job only runs if the node is powered on at that moment; missed runs are not caught up by default. Backup jobs are now checked after any outage, and `repeat-missed` / more frequent schedules are part of the roadmap.
