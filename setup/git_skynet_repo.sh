function git::skynet() {
  if which git; then 
    git clone https://github.com/picatz/skynet.git
  else
    curl https://github.com/picatz/skynet/archive/master.zip -O
    unzip master.zip -d skynet
    rm master.zip
  fi
}

function main() {
  git::skynet  
}

main
