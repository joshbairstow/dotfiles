#!/bin/sh

echo -e "\n\nInstalling NVM and Node"
echo "=============================="

if test ! $(which nvm); then
  echo "Installing NVM"
  ruby -e "$(curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash)"
fi

# reload nvm into this environment
NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

nvm install stable
nvm alias default stable
