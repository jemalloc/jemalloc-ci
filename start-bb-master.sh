#!/usr/bin/env bash

set -e

if [[ ! -e ~/secrets/ ]]; then
  echo "Couldn't find a secrets dir!"
  exit 1
fi

cd
cd bb-dir
source sandbox/bin/activate
buildbot start master
