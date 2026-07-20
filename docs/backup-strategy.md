# Backup Strategy

## Objectives

Protect:

- Proxmox workloads
- Application configurations
- Databases
- Docker persistent data
- Nextcloud data
- Infrastructure documentation
- Recovery instructions

## Backup Layers

### Layer 1: Proxmox Backups

Periodic backups of important LXC containers and virtual machines.

### Layer 2: Application Backups

Application-specific backups of configuration files and persistent volumes.

### Layer 3: Database Backups

Database dumps created separately from filesystem backups.

### Layer 4: External Copies

Critical backups are copied to another location or storage system.

### Layer 5: Restoration Testing

A backup is not considered reliable until restoration has been tested.

## Suggested Recovery Priorities

1. Network access services
2. Authentication and management services
3. Databases
4. Critical applications
5. User data
6. Non-critical applications

## Information Excluded

This repository does not contain:

- Backup server addresses
- Storage mount paths
- Access credentials
- Encryption keys
- Remote storage tokens
- Personal data
