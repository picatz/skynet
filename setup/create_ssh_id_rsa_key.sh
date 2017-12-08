function create::ssh_keys() {
  ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''  
}

function main() {
  create::ssh_keys  
}

main
