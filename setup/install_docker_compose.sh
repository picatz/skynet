function install::docker_compose() {
  sudo pip install docker-compose
}

function main() {
  install::docker_compose
}

main
