function install::git() {
  # if already installed
  if which git; then return; fi
  # else install it
  sudo apt install git -y
}

function install::go() {
  # if already installed
  if which go; then return; fi
  # else install it
  sudo apt install golang-go -y
}

function install::iface() {
  export GOPATH=$PWD
  go get github.com/urfave/cli
  git clone https://github.com/picatz/iface.git
  cd iface 
  go build iface.go
  sudo cp iface /usr/bin
  cd ..
  rm -rf iface 
}

function main() {
  install::git
  install::go
  install::iface
}

main
