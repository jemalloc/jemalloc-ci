#!/usr/bin/env bash

apt-get install git

apt-get install -y python
apt-get install -y python-pip
apt-get install -y virtualenv

apt-get install -y ufw
ufw allow 'OpenSSH'

apt-get install -y nginx
ufw allow 'Nginx Full'

apt-get install -y letsencrypt

apt-get install -y jq

# TODO: once security situation is figured out
# ufw enable
