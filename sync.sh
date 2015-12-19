DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

file_exists() {
  [[ -e "$1" || -h "$1" ]]
}

program_exists() {
  hash $1 2>/dev/null
}

print_alert() {
  printf "\e[0;35m$1\e[0m\n"
}

print_error() {
  printf "\e[0;31m$1\e[0m\n"
}

print_success() {
  printf "\e[0;32m$1\e[0m\n"
}

ask_for_sudo() {
  sudo -v; while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}

ask_yes_or_no() {
  read -p "-> $1? (y/n) " -n 1; printf "\n"
}

response_was_yes() {
  [[ "$REPLY" =~ ^[Yy]$ ]]
}

install_atom() {
  brew cask install atom
}

install_parcel() {
  if program_exists 'apm'; then
    apm install parcel
  else
    print_alert "Error: Unable to install Parcel (required for Atom)"
  fi
}

create_symlink() {
  path=$2/$(basename "$1")
  if file_exists $path; then ask_yes_or_no "Overwrite $path"
    if response_was_yes; then
      ln -sf $DOTFILES_DIR/$1 $2
    fi
  else
    ln -sf $DOTFILES_DIR/$1 $2
  fi
}

create_symlink .inputrc ~
create_symlink git/.gitconfig ~
create_symlink git/.gitignore_global ~

if ! program_exists 'atom'; then ask_yes_or_no "Install Atom text editor"
  if response_was_yes; then
    install_atom
  fi
fi

if program_exists 'atom'; then
  if [ ! -d ~/.atom/packages/parcel ]; then
    install_parcel
  fi
  create_symlink atom/init.coffee ~/.atom
  create_symlink atom/config.cson ~/.atom
  create_symlink atom/keymap.cson ~/.atom
  create_symlink atom/packages.cson ~/.atom
  create_symlink atom/snippets.cson ~/.atom
  create_symlink atom/styles.less ~/.atom
fi

#if [ -d ~/Library/Application\ Support/Sublime\ Text\ 3/Packages ]; then
#  ask_yes_or_no "Create symlink for SublimeText 3"
#  if response_was_yes; then
#    ln -sf "$DOTFILES/sublime/User" ~/Library/Application\ Support/Sublime\ Text\ 3/Packages
#  fi
#fi
