#!/usr/bin/env bash

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && git rev-parse --show-toplevel)

MASTER_HOST=`jq --raw-output '.["master_host"]' ~/secrets/public.json`
ADMIN_EMAIL=`jq --raw-output '.["admin_email"]' ~/secrets/public.json`

if [[ -z $MASTER_HOST || -z $ADMIN_EMAIL ]]; then
  echo "Trouble config info from ~/secrets/public.json"
  exit 1
fi

# Get our configuration files where we want them.
cp "$ROOT_DIR/nginx/master.nginx.conf" /etc/nginx/sites-available/master
cp "$ROOT_DIR/nginx/master-bootstrap.nginx.conf" /etc/nginx/sites-available/master-bootstrap
cp "$ROOT_DIR/nginx/ssl-params.nginx.conf" /etc/nginx/snippets/ssl-params.conf


# Rewrite the configuration files to use whatever hostname we're configured for.
sed -i "s/MASTER_HOST_PLACEHOLDER/$MASTER_HOST/" /etc/nginx/sites-available/master
sed -i "s/MASTER_BB_PORT_PLACEHOLDER/$MASTER_BB_PORT/" /etc/nginx/sites-available/master
sed -i "s/MASTER_HOST_PLACEHOLDER/$MASTER_HOST/" /etc/nginx/sites-available/master-bootstrap
sed -i "s/MASTER_BB_PORT_PLACEHOLDER/$MASTER_BB_PORT/" /etc/nginx/sites-available/master-bootstrap

# First, we stand up the http server we use to get letsencrypt certs.
ln -s /etc/nginx/sites-available/master-bootstrap /etc/nginx/sites-enabled/master-bootstrap
systemctl restart nginx

# Used by letsencrypt.
mkdir /var/www/well-known

# Get the certs.
letsencrypt certonly -a webroot --webroot-path=/var/www/well-known \
  -d $MASTER_HOST --non-interactive --agree-tos --email $ADMIN_EMAIL

# Set up the Diffie-Hellman parameters.
openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

# Encryption is set up; we can use our main config  We leave the bootstrap in
# effect for cert renewal.
ln -s /etc/nginx/sites-available/master /etc/nginx/sites-enabled/master
systemctl restart nginx
