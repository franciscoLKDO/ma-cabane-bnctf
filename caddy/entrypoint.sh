#!/bin/sh
set -eu

certificate=/certs/server-cert.pem
private_key=/certs/server-key.pem

if [ -s "$certificate" ] && [ -s "$private_key" ]; then
  echo "Using the certificate and private key mounted in /certs."
  config=/etc/caddy/Caddyfile.provided-certs
elif [ -e "$certificate" ] || [ -e "$private_key" ]; then
  echo "Both server-cert.pem and server-key.pem must be supplied together." >&2
  exit 1
else
  echo "No certificate supplied; Caddy will request one from Let's Encrypt."
  config=/etc/caddy/Caddyfile
fi

exec caddy run --config "$config" --adapter caddyfile
