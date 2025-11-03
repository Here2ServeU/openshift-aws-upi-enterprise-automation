# Restore Runbook (Velero)
- Validate S3 bucket & credentials.
- List backups: `velero backup get`
- Restore namespace: `velero restore create --from-backup <name>`
- Verify app health, DNS, and secrets.
