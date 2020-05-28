function _zsh_git_scripts_git_diff () {
  local params=($(__zsh_git_scripts_convert_indices "$@"))

  git diff $params
}
