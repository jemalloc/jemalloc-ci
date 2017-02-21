#!/usr/bin/env bash

set -e

# Should be run as root.

apt-get install -y git

apt-get install -y autoconf
apt-get install -y make

apt-get install -y cmake

apt-get install -y gcc
apt-get install -y g++

apt-get install -y clang

apt-get install -y python
apt-get install -y python-pip
apt-get install -y virtualenv

apt-get install -y jq
