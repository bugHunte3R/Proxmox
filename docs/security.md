# Security

## Model

1. **No inbound ports.** Public apps are reached only through an outbound Cloudflare Tunnel.
2. **Admin interfaces are private-network only**, SSH by key.
3. **Role separation**: tunnel, network controller, Docker apps, client staging and Nextcloud are separate guests.
4. **Unprivileged LXC** wherever privileges are not needed.
5. **Nextcloud in a VM** — its own kernel and disk for personal data.
6. **Least privilege**: day-to-day administration with a non-root account, elevated rights granted temporarily.
7. **Secrets stay on the machines** in protected files — never in Git.
8. **Snapshot + backup before every change.**
9. **Staging hardening**: no indexing, HSTS, CSP, rate-limited sign-in, no Git credentials on the server.

## Public documentation rules

This repository never contains: addresses (public or private), hostnames, domains, guest IDs, exact software versions, open ports, hardware identifiers, account names, e-mail addresses, credentials, tokens, keys, VPN profiles, router/firewall exports or personal data.

## If a secret leaks

1. Revoke / rotate it immediately
2. Remove it from the files **and** from Git history
3. Review logs for use of the secret
4. Add the pattern to `.gitignore`
