run_with_bundler() {
  if [ -e ./Gemfile ]; then
    echo "bundle exec $@"
    bundle exec $@
  else
    $@
  fi
}

cd_project_dir() {
  if [ -d $HOME/Projects ]; then
    cd $HOME/Projects/$1
  else
    echo "Error: No project directory found."
  fi
}

open_pivotal_story() {
  open "https://www.pivotaltracker.com/story/show/$1"
}
