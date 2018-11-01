# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Load chruby
if [ -f /usr/local/opt/chruby/share/chruby/chruby.sh ]; then
  source /usr/local/opt/chruby/share/chruby/chruby.sh
  source /usr/local/opt/chruby/share/chruby/auto.sh
fi

# Load git helpers
source $DOT_DIR/git/git-prompt.sh
source $DOT_DIR/git/git-completion.bash

# Customize prompt
PS1='\[\e[36m\]\u \w\[\e[0m\]\[\e[35m\]$(__git_ps1 " (%s)") \$\[\e[0m\] '

# Case-insensitive tab completion
set completion-ignore-case on
