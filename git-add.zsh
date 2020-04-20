# Note: This is not called 'ga' because I don't want to interfere
# with user's default aliases.
function _git_add () {
  if [ ${#@} = 0 ]; then
    echo "No arguments"
    return
  fi

  local params=($(__convert_indices "$@"))

  echo "Adding $params"
  git add $params
}
