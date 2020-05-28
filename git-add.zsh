function _zsh_git_scripts_git_add () {
  if [ ${#@} = 0 ]; then
    echo "No arguments"
    return
  fi

  local params=($(__zsh_git_scripts_convert_indices "$@"))

  echo "Adding $params"
  git add $params
}
