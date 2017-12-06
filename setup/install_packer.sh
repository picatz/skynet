function install::unzip() {
  # if already installed
  if which unzip; then return; fi
  # else install it
  sudo apt install unzip -y
}

function install::packer() {
  mkdir packer_download
  cd packer_download
  wget https://releases.hashicorp.com/packer/1.1.2/packer_1.1.2_linux_amd64.zip  
  unzip packer_1.1.2_linux_amd64.zip -d .
  sudo mv packer /usr/bin/
  cd ..
  rm -rf packer_download 
}

function main() {
  install::unzip
  install::packer
}

main
