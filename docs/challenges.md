# Challenges and Lessons Learned

## Network Address Changes

Changing internal addresses can affect:

- Reverse-tunnel routes
- Docker services
- DNS records
- Trusted-host settings
- VPN routes
- Monitoring targets

**Lesson learned:** maintain an addressing plan and validate dependencies before making network changes.

## Cloudflare Connector Stability

Troubleshooting required reviewing:

- Connector service status
- Transport protocol
- Network availability
- systemd restart policy
- Connector redundancy
- Local application availability

**Lesson learned:** troubleshoot the local application and the connector separately.

## Docker Deployments

Changes may remain invisible because of:

- Browser cache
- Proxy cache
- Old container images
- Incorrect build context
- Incorrect file names
- Containers not recreated after a build

**Lesson learned:** validate source files, build output, running images and external cache independently.

## Nextcloud Reverse Proxy

Reverse-proxy deployment required attention to:

- Trusted domains
- Trusted proxies
- HTTPS overwrite settings
- Forwarded headers
- WebDAV
- PHP modules
- Background jobs
- File permissions

**Lesson learned:** application availability does not guarantee full feature correctness.

## WireGuard Routing

VPN connectivity required validating:

- Handshake status
- UDP forwarding
- NAT
- Kernel IP forwarding
- Firewall forwarding rules
- Allowed IPs
- DNS
- Client routes

**Lesson learned:** a successful handshake confirms authentication, not complete routing.

## Service Isolation

Dedicated containers consume extra resources but provide:

- Easier troubleshooting
- Clear responsibilities
- Reduced dependency conflicts
- Better backup granularity
- Stronger security boundaries
