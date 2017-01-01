#!/bin/sh

echo -e "\n\nInstalling RVM"
echo "=============================="

if test ! $(which rvm); then
  echo "Installing RVM"
  ruby -e "$(curl -sSL https://get.rvm.io | bash -s -- --ignore-dotfiles | bash)"
fi
