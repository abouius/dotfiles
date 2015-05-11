# figure out dotfiles directory path
CURRENT_SCRIPT=${BASH_SOURCE}
READLINK=$(which readlink)
if [[ -n $CURRENT_SCRIPT && -x "$READLINK" ]]; then
  DOTFILES=$(dirname $($READLINK "$CURRENT_SCRIPT")})
elif [ -d "$HOME/.dotfiles" ]; then
  DOTFILES="$HOME/.dotfiles"
elif [ -d "$HOME/Projects/.dotfiles" ]; then
  DOTFILES="$HOME/Projects/.dotfiles"
else
  echo "Unable to locate dotfiles directory, exiting."
  return
fi

# make path available
export DOTFILES

# source repo dotfiles
for DOTFILE in "$DOTFILES"/.{aliases,functions,prompt}; do
  [ -f "$DOTFILE" ] && source "$DOTFILE"
done

# source user dotfiles
for DOTFILE in ~/.{bashrc,profile,extra}; do
  [ -f "$DOTFILE" ] && source "$DOTFILE"
done

# add dotfiles bin folder to $PATH
export PATH="$DOTFILES/bin:$PATH"

# add user bin folder to $PATH
if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi

# cleanup
unset READLINK CURRENT_SCRIPT DOTFILE
