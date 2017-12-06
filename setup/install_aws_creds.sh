function install::aws::credentials() {
  echo "export AWS_ACCESS_KEY_ID=\"$1\"" >> ~/.bashrc
  echo "export AWS_SECRET_ACCESS_KEY=\"$2\"" >> ~/.bashrc
  echo "export AWS_DEFAULT_REGION=\"$3\"" >> ~/.bashrc
}

function main() {
  install::aws::credentials "$1" "$2" "$3"
}

main "$1" "$2" "$3"
