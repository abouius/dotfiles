# get current directory
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# load dotfiles
for dotfile in $DOTFILES_DIR/.{functions,aliases,loaders,prompt}; do
  [ -f $dotfile ] && source $dotfile
done
unset dotfile

# update path
export PATH="/usr/local/sbin:$PATH:$DOTFILES_DIR/bin"
