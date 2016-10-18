#!/usr/bin/env bash
#
# bootstrap installs things.

DOTFILES_ROOT=~/.dotfiles

set -e

echo ''

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

link_files () {
  ln -s $1 $2
  h_success "linked $1 to $2"
}

install_dotfiles () {
  h_info 'installing dotfiles'

  overwrite_all=false
  backup_all=false
  skip_all=false

  for source in `find $DOTFILES_ROOT -maxdepth 2 -name \*.symlink`
  do
    dest="$HOME/.`basename \"${source%.*}\"`"

    if [ -f $dest ] || [ -d $dest ]
    then

      overwrite=false
      backup=false
      skip=false

      if "$overwrite_all" == "false" && "$backup_all" == "false" && "$skip_all" == "false"
      then
        h_user "File already exists: `basename $source`, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac
      fi

      if "$overwrite" == "true" || "$overwrite_all" == "true"
      then
        rm -rf $dest
        h_success "removed $dest"
      fi

      if "$backup" == "true" || "$backup_all" == "true"
      then
        mv $dest $dest\.backup
        h_success "moved $dest to $dest.backup"
      fi

      if "$skip" == "false" && "$skip_all" == "false"
      then
        link_files $source $dest
      else
        h_success "skipped $source"
      fi

    else
      link_files $source $dest
    fi

  done
}

install_dotfiles