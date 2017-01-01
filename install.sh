#!/usr/bin/env bash

h_info () {
  printf "  [ \033[00;34m..\033[0m ] $1"
}

h_user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

h_success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

h_fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

h_info "Installing dotfiles"

h_info "Initializing submodule(s)"
git submodule update --init --recursive

source script/link.sh

if [ "$(uname)" == "Darwin" ]; then
  h_info "\n\nRunning on OSX"

  # includes tool install through brew pkg manager (apt for nix)
  source script/brew.sh
fi

if [ "$(uname)" == "Linux" ]; then
  h_info "\n\nRunning on Linux"

  source script/apt.sh
fi

source script/nvm.sh

# for backup of vim overwrite (symlinking neovim config to current vim)
h_info "Creating vim directories"
mkdir -p ~/.vim-tmp


h_info "Configuring zsh as default shell"
chsh -s $(which zsh)

h_success "Done."
