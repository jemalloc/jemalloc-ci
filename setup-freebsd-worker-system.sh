#!/usr/bin/env sh

# Should be run as root.

# Not sure how we got here if git isn't already installed, but it doesn't hurt
# to check.
pkg install -y git

# Needed to build jemalloc.
pkg install -y autoconf
pkg install -y gmake

# May be needed in the future to build jemalloc.
pkg install -y cmake

# We want to test with gcc and g++, too.
pkg install -y gcc

# buildbot worker scripts are python.
pkg install -y python

# Using bash as our shell across both Linux and FreeBSD keeps things more
# uniform.
pkg install -y bash

# Passwords are stored in json files in ~/secrets. Sometimes we need to parse
# them from bash.
pkg install -y jq

# Virtualenv lives in ports.
portsnap fetch
portsnap extract
cd /usr/ports/devel/py-virtualenv
BATCH=yes make install clean
