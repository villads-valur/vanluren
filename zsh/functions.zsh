kill_port() {
  if [[ -z "$1" ]]; then
    echo "Pass in port number."
    return 1
  fi
  lsof -ti :"$1" | xargs kill -9
}
