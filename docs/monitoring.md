# Monitoring and Maintenance

## Monitoring Areas

- CPU and memory usage
- Storage capacity
- Proxmox node health
- LXC container state
- Docker container state
- systemd service failures
- Application availability
- Cloudflare connector status
- WireGuard handshake and routing
- Nextcloud background jobs
- Backup completion

## Generic Linux Checks

```bash
uptime
free -h
df -h
systemctl --failed
journalctl -p err -b
```

## Docker Checks

```bash
docker ps
docker compose ps
docker compose logs --tail=100
docker system df
```

## Network Checks

```bash
ip address
ip route
ss -tulpn
ping -c 4 192.0.2.1
```

## Maintenance Practices

- Review failed services after updates
- Validate application access after redeployment
- Verify disk space before upgrades
- Review logs after network changes
- Test backups periodically
- Keep documentation updated when services move
