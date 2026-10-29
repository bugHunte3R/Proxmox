# Roadmap

## Backups

- More frequent schedules for personal data, `repeat-missed` for jobs missed during outages
- PBS verify jobs and documented restore tests
- Off-site copy of the backup datastore

## Resilience

- Corosync QDevice for a third vote
- ZFS + storage replication, then HA for the tunnel connector
- Second tunnel connector replica on the other node

## Access and security

- Remote-administration VPN or Zero Trust access in front of admin interfaces
- Datacenter firewall rules
- Enforced two-factor authentication on all admin interfaces

## Observability

- Prometheus + Grafana + Proxmox exporter running permanently
- Uptime checks on public endpoints with alerting

## Long-term

- Cluster described as code (Ansible)
- Disaster-recovery runbook from bare metal, with timings
