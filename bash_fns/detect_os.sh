function detect_os()
{
  if [[ $OSTYPE =~ freebsd ]]; then
    echo "freebsd"
    return 0
  elif [[ $OSTYPE =~ darwin ]]; then
    echo "osx"
    return 0
  elif [[ $OSTYPE =~ linux-gnu ]]; then
    if [[ `lsb_release -si` == "Ubuntu" ]]; then
      echo "ubuntu"
      return 0
    fi
  else
    echo "Couldn't detect OS"
    return 1
  fi
}
