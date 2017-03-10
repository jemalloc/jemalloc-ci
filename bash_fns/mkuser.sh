source "$ROOT_DIR/bash_fns/detect_os.sh"

function mkuser() {
  local UN="$1"
  local PW="$2"
  if [[ `detect_os` == "ubuntu" ]]; then
    deluser --remove-home $UN || true
    adduser --disabled-login --gecos "" $UN
    echo $UN:$PW | chpasswd
    return 0
  elif [[ `detect_os` == "freebsd" ]]; then
    rmuser -y $UN || true
    echo $UN::::::::bash:$PW | adduser -f -
    return 0
  else
    echo "Don't know how to create a user for this OS"
    return 1
  fi
}
