# Monitoring and Maintenance

## Cluster health

```bash
pveversion
pvecm status            # quorum and votes
corosync-cfgtool -s     # link to the other node
pvesm status            # all storages active
ha-manager status
pvesh get /cluster/resources --type vm
apt list --upgradable
```

## Guests

```bash
pct list ; qm list
pct exec <id> -- systemctl --failed
pct exec <id> -- df -h /
pct exec <id> -- ss -lntup
qm guest exec <id> -- systemctl is-active apache2 mariadb redis-server
```

## Docker

```bash
docker ps -a
docker compose ps
docker compose logs --tail=100
docker system df
docker builder prune --filter until=48h
```

## Public endpoints

```bash
curl -sI https://<public-hostname>
journalctl -u cloudflared --since -1h
```

## Backups

```bash
pvesm list <pbs-storage>
pvesh get /nodes/<node>/tasks --typefilter vzdump --limit 10
```

## Maintenance routine

- Snapshot the guest, then update; delete the snapshot once validated
- Boot order set so the most important guest starts first after a power cut
- Check `systemctl --failed` and the public URLs after any update
- Check the latest backup tasks after any outage
