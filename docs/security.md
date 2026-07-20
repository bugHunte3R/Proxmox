# Security

## Security Principles

1. Do not expose management interfaces publicly.
2. Use VPN access for private administration.
3. Publish only selected applications.
4. Separate infrastructure services.
5. Store secrets outside version control.
6. Keep operating systems and applications updated.
7. Back up critical data.
8. Review failed services and logs.
9. Apply least privilege where possible.
10. Sanitize all public documentation.

## Secret Management

Secrets should be stored in local environment files or protected configuration files.

Examples:

```text
.env
*.key
*.pem
credentials.json
config-production.yml
```

These files must never be committed.

## Sensitive Information

The following information must not appear in the public repository:

- Passwords
- API keys
- Authentication tokens
- Cloudflare tunnel tokens
- Tunnel credential JSON files
- WireGuard private keys
- SSH private keys
- Database credentials
- SMTP credentials
- Real public addresses
- Real internal addresses
- Real domains
- Email addresses
- MAC addresses
- Backup credentials
- Session cookies
- QR codes containing VPN configurations

## Public Screenshots

Before publishing a screenshot:

- Hide IP addresses
- Hide hostnames that identify the environment
- Hide usernames
- Hide domains
- Hide email addresses
- Hide MAC addresses
- Hide serial numbers
- Hide storage identifiers
- Hide tunnel identifiers
- Hide QR codes
- Hide browser tabs containing private information
- Hide notifications
- Remove image metadata

## Incident Response

If a secret is accidentally committed:

1. Revoke or rotate the secret immediately.
2. Replace the exposed credential.
3. Remove it from current files.
4. Remove it from Git history.
5. Review service logs.
6. Confirm that no unauthorized access occurred.
7. Add the sensitive pattern to `.gitignore`.
