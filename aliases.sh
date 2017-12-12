alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias l="ls -l"
alias la="ls -la"
alias cdp="cd_project_dir"

alias gb="git branch"
alias gs="git status"
alias ga="git add -A"
alias gp="git pull --rebase"
alias co="git checkout"
alias undo_commit="git reset --soft HEAD~"
alias clean_branches="git remote prune origin; git branch --merged | grep -v '\*' | grep -v dev | xargs -n 1 git branch -d"

alias nginx.start="sudo nginx"
alias nginx.stop="sudo nginx -s quit"
alias nginx.restart="sudo nginx -s reload"
alias nginx.test="sudo nginx -t"

alias pivotal="open_pivotal_story"

for cmd in irb rake pry spec rspec puma rails rackup guard; do
  alias $cmd="run_with_bundler $cmd"
done
