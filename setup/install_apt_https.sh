function install::apt::https_support() {
  sudo apt-get install -y apt-transport-https ca-certificates
}

function main() {
  install::apt::https_support
}

main
