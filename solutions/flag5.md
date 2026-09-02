# Solution — The Debug Trail

Use the browser Network panel to identify the unexpected WebSocket host. Visit
the same host over HTTPS and enumerate its common documentation paths. The
server exposes Swagger UI below `/swagger` and its OpenAPI document at:

```text
/swagger/openapi.json
```

The summary for `GET /admin/connections` contains the flag.