run_with_bundler() {
  if [ -e ./Gemfile ]; then
    echo "bundle exec $@"
    bundle exec $@
  else
    $@
  fi
}

cd_project_dir() {
  if [ -n "$PROJECTS_DIR" ]; then
    cd $PROJECTS_DIR/$1
  elif [ -d $HOME/Projects ]; then
    cd $HOME/Projects/$1
  else
    echo "Error: No project directory found."
  fi
}
