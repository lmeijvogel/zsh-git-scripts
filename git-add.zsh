# Note: This is not called 'ga' because I don't want to interfere
# with user's default aliases.
function _git_add () {
  local params=()

  if [ ${#@} = 0 ]; then
    echo "No arguments"
    return
  fi

  local params=()
  for x in $@; do
    local filename=$_git_indices[$x]

    if [ "$filename" != "" ];then
      params[$x]=$filename
    else
      params[$x]=$x
    fi
  done

  echo "Adding $params"
  git add $params
}
