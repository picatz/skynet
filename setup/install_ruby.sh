function install::rvm() {
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  curl -sSL https://get.rvm.io | bash -s stable 
}

function install::rvm_bashrc() {
  source /home/$USER/.rvm/scripts/rvm
  echo "source /home/$USER/.rvm/scripts/rvm" >> ~/.bashrc
}

function install::ruby_via_rvm() {
  source /home/$USER/.rvm/scripts/rvm # good measure
  rvm install 2.4.2
  rvm use ruby-2.4.2 --default
}

function main() {
  install::rvm
  install::rvm_bashrc
  install::ruby_via_rvm
}

main
