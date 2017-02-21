#!/usr/bin/env bash

set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd
rm -rf bb-dir
mkdir bb-dir
cd bb-dir
virtualenv sandbox
source sandbox/bin/activate
pip install 'buildbot[bundle]'==0.9.4
pip install txrequests
buildbot create-master master
cp "$SCRIPT_DIR"/bb_master_config/* master/
