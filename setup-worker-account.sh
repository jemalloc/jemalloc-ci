#!/usr/bin/env bash

set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$SCRIPT_DIR/bash_fns/mkuser.sh"

if [[ -z $WORKER_UNIX_SECRETS_FILE ]]; then
  echo "Need WORKER_UNIX_SECRETS_FILE=[ubuntu|freebsd]_unix_secrets.json defined!"
  exit 1
fi

UN=`jq --raw-output '.["unix_un"]' ~/secrets/"$WORKER_UNIX_SECRETS_FILE"`
PW=`jq --raw-output '.["unix_pw"]' ~/secrets/"$WORKER_UNIX_SECRETS_FILE"`

mkuser "$UN" "$PW"
