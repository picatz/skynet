function apt::upgrade() {
  sudo apt-get upgrade -y
}

function apt::update() {
  sudo apt-get update -y 
}

function main() {
  apt::upgrade
  apt::update
}

main
