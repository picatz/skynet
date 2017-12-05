function install::httpd() {
  # if already installed
  if which httpd; then return; fi
  # else install it
  sudo yum install httpd -y
}

function main() {
  install::httpd
}

main
