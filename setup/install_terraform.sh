function install::unzip() {
  # if already installed
  if which unzip; then return; fi
  # else install it
  sudo apt install unzip -y
}

function install::terraform() {
  mkdir terrform_download
  cd terrform_download
  wget https://releases.hashicorp.com/terraform/0.11.0/terraform_0.11.0_linux_amd64.zip  
  unzip terraform_0.11.0_linux_amd64.zip -d .
  sudo mv terraform /usr/bin/
  cd ..
  rm -rf terrform_download
}

function main() {
  install::unzip
  install::terraform
}

main
