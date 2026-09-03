# Ma Cabane — BNCTF supply-chain challenge

Ma Cabane is a blue-team CTF scenario about a compromised frontend build
dependency. Players investigate production-only behaviour, follow the build
chain across repositories, examine Git history, and pivot to the infrastructure
used by the compromised artifact.

The challenge contains seven flags and is designed as one connected incident
investigation. It combines browser analysis, Git forensics, CI/CD review, API
enumeration, and credential recovery.

## Scenario

Customers report a strange popup appearing on the production maple-products
site. The frontend team cannot reproduce it with a local build, and no matching
popup exists in the application source.

## Learning objectives

By completing the CTF, players should be able to:

- compare local source and build output with a deployed artifact;
- inspect GitHub Actions workflows and third-party Actions;
- explain why a movable Git tag is unsafe for a trusted build dependency;
- recover deleted sensitive data from Git history;
- enumerate an HTTP API from exposed documentation;
- recognize inconsistent URL normalization and authorization checks;
- connect findings from separate stages into an incident timeline; and
- recommend practical containment and supply-chain hardening measures.

## Services

The Compose stack creates a private `login` network and runs these services:

- `caddy` terminates TLS and routes the public challenge hostnames. It uses
  mounted certificates when supplied and otherwise obtains certificates from
  Let's Encrypt;
- `backend` serves the Ma Cabane website and its final login stage;
- `telemetry-ws-server` exposes the controlled HTTP/WebSocket service used by
  the investigation; and
- `github-runner` optionally provides the dedicated self-hosted runner used to
  build releases inside the challenge network.

The expected public hostnames are:

- `ma-cabane.challenges.bnctf.com` — web application;
- `telemetricks.challenges.bnctf.com` — telemetry HTTP and WebSocket service.

Both names must resolve publicly to the Docker host. Ports 80 and 443 must be
reachable for normal challenge traffic.

## Configuration

Create a `.env` file beside `compose.yaml`. At minimum, set unique values for
the required login fields:

```dotenv
LOGIN_USERNAME=<challenge username>
LOGIN_PASSWORD=<challenge password>
LOGIN_FLAG=<final flag>
```

Useful optional settings are:

```dotenv
# Directory containing optional provided certificates.
TLS_CERTS_SOURCE=./certs

HTTP_PORT=80
TELEMETRY_HTTPS_PORT=443
ALLOWED_ORIGINS=https://ma-cabane.challenges.bnctf.com
TELEMETRY_ADMIN_TOKEN=<random organizer-only token>
POPUP_DELAY_MS=3000
POPUP_TEXT=Votre session a expiré. Rechargez la page.

LOGIN_RATE_LIMIT_MAX_ATTEMPTS=5
LOGIN_RATE_LIMIT_WINDOW_MS=900000
```

Do not use the default administrative token outside an isolated local test.
Keep `.env`, registry credentials, runner tokens, and private keys out of Git.

### TLS certificates

The stack supports two TLS modes.

#### Provide certificates

Set `TLS_CERTS_SOURCE` to a directory containing these files:

```text
server-cert.pem
server-key.pem
```

The certificate must cover both `ma-cabane.challenges.bnctf.com` and
`telemetricks.challenges.bnctf.com`. Caddy mounts the directory read-only and
uses the provided certificate and key.

If only one of `server-cert.pem` or `server-key.pem` exists, Caddy refuses to
start.

#### Let Caddy manage certificates

Leave both `server-cert.pem` and `server-key.pem` absent and start the stack
normally. Caddy then obtains and renews publicly trusted certificates through
Let's Encrypt. Before starting Caddy, ensure public DNS for both hostnames
points to this host and inbound TCP ports 80 and 443 are open.

Caddy stores its ACME account and issued certificates in the persistent
`caddy-data` volume, so do not delete that volume during routine deployments.
Issuance and renewal events are visible with:

```bash
docker compose logs -f caddy
```

## Running locally

Prerequisites:

- Docker Engine with Docker Compose v2;
- access to the container images referenced in `compose.yaml`;
- DNS entries for both challenge hostnames; and
- ports 80 and 443 available, unless overridden in `.env`.

To use the included private CA instead of Caddy-managed certificates, generate
the TLS files before starting the services:

```bash
./scripts/generate-certs.sh
```

to use the generated certificates locally:
- import the server `ca-cert.pem` certificate to your browser
- write your /etc/hosts to redirect  `ma-cabane.challenges.bnctf.com` and `telemetricks.challenges.bnctf.com` to caddy ip

Start the public challenge services:

```bash
docker compose up -d
docker compose ps
```

Start the optional release runner only when its credentials and network access
have been prepared:

```bash
docker compose --profile runner up -d
```

Stop the stack without deleting its named volumes:

```bash
docker compose down
```

## Author

Created by Franck Holé for BNCTF.
