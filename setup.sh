DOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

file_exists() {
  [[ -e "$1" || -h "$1" ]]
}

program_exists() {
  hash $1 2>/dev/null
}

ask_yes_or_no() {
  read -p "-> $1? (y/n) " -n 1; printf "\n"
}

response_was_yes() {
  [[ "$REPLY" =~ ^[Yy]$ ]]
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

make_symlink() {
  path=$2/$(basename "$1")
  if file_exists $path; then ask_yes_or_no "Overwrite $path?"
    if response_was_yes; then
      ln -sf $DOT_DIR/$1 $2
    fi
  else
    ln -sf $DOT_DIR/$1 $2
  fi
}

make_symlink .inputrc ~
make_symlink git/.gitconfig ~
make_symlink git/.gitignore_global ~
