# Note: This is not called 'ga' because I don't want to interfere
# with user's default aliases.
function _git_diff () {
  local params=($(__convert_indices "$@"))

  git diff $params
}
