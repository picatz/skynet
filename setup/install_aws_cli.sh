function install::pip() {
  # if already installed
  if which pip; then return; fi
  # else install it
  sudo apt install python-pip -y
}

function upgrade::pip() {
  pip install --upgrade pip
}

function install::aws::cli() {
  pip install awscli --upgrade --user
}

function main() {
  install::pip
  install::aws::cli
  upgrade::pip
}

main
