#!/bin/sh
set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
cert_dir=${CERT_DIR:-"$script_dir"}
days=${CERT_DAYS:-825}

mkdir -p "$cert_dir"

ca_key="$cert_dir/ca-key.pem"
ca_cert="$cert_dir/ca-cert.pem"
server_key="$cert_dir/server-key.pem"
server_csr="$cert_dir/server.csr"
server_cert="$cert_dir/server-cert.pem"
extensions="$cert_dir/server-ext.cnf"

if [ -e "$ca_key" ] || [ -e "$ca_cert" ] || [ -e "$server_key" ] || [ -e "$server_cert" ]; then
  echo "Certificate files already exist in $cert_dir; refusing to overwrite them." >&2
  echo "Remove the existing files explicitly if you intend to rotate the CA." >&2
  exit 1
fi

cleanup() {
  rm -f "$server_csr" "$extensions"
}
trap cleanup EXIT HUP INT TERM

openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:4096 -out "$ca_key"
openssl req -x509 -new -sha256 -key "$ca_key" -days "$days" \
  -subj "/CN=Ma Cabane local CA" \
  -addext "basicConstraints=critical,CA:TRUE" \
  -addext "keyUsage=critical,keyCertSign,cRLSign" \
  -out "$ca_cert"

openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out "$server_key"
openssl req -new -sha256 -key "$server_key" \
  -subj "/CN=ma-cabane.challenges.bnctf.com" \
  -out "$server_csr"

printf '%s\n' \
  'basicConstraints=critical,CA:FALSE' \
  'keyUsage=critical,digitalSignature,keyEncipherment' \
  'extendedKeyUsage=serverAuth' \
  'subjectAltName=DNS:ma-cabane.challenges.bnctf.com,DNS:telemetricks.challenges.bnctf.com' \
  > "$extensions"

openssl x509 -req -sha256 -in "$server_csr" \
  -CA "$ca_cert" -CAkey "$ca_key" -CAcreateserial \
  -days "$days" -extfile "$extensions" -out "$server_cert"

chmod 600 "$ca_key" "$server_key"
chmod 644 "$ca_cert" "$server_cert"

echo "Generated certificates in $cert_dir:"
echo "  CA certificate:     $ca_cert"
echo "  Server certificate: $server_cert"
echo "  Server private key: $server_key"
