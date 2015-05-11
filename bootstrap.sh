# current directory
export DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# installation helpers
file_exists() {
  [ -e "$1" ]
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

ask_yes_or_no() {
  read -p "-> $1? (y/n) " -n 1; printf "\n"
}

response_was_yes() {
  [[ "$REPLY" =~ ^[Yy]$ ]]
}

create_symlink() {
  if file_exists ~/$(basename "$1"); then ask_yes_or_no "Overwrite $(basename "$1")"
    if response_was_yes; then ln -sf "$DOTFILES/$1" ~; fi
  else
    ln -sf "$DOTFILES/$1" ~
    print_alert "Creating symlink for $(basename "$1")"
  fi
}

ask_for_sudo() {
  sudo -v; while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}

program_exists() {
  hash $1 2>/dev/null
}

# add symlinks
create_symlink ".bash_profile"
create_symlink ".inputrc"
create_symlink "git/.gitconfig"
create_symlink "git/.gitignore_global"

if [ -d ~/Library/Application\ Support/Sublime\ Text\ 3/Packages ]; then
  ask_yes_or_no "Create symlink for SublimeText 3"
  if response_was_yes; then
    ln -sf "$DOTFILES/sublime/User" ~/Library/Application\ Support/Sublime\ Text\ 3/Packages
  fi
fi
