function install::initial_deps() {
  # Becasue official docs say so
  sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
  # Becasue official docs say so
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt-get update -y
}

function install::docker() {
  sudo apt-get install docker-ce -y
}

function main() {
  install::initial_deps
  install::docker
}

main
