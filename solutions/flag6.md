# Solution — Hackers Hacked

The request handler performs its authorization check against the raw URL path,
then URL-decodes the path before looking it up in the routing table. Encode one
character in `admin` so the raw path does not begin with `/admin/`, while the
decoded path still resolves to the administrative route:

```bash
curl 'https://<telemetry-host>/%61dmin/connections'
```

No bearer token is required for this encoded form. One seeded connection uses
its `version` field to expose the flag. The same record also contains the
username and an MD5 password hash needed for the final step.