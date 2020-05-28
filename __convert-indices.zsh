# Will return the given array to the
# corresponding filenames.
#
# Remember to split the result when passing the
# result into a shell command.
function __zsh_git_scripts_convert_indices () {
  local result=()

  local indices=()
  if [[ "$@" = *-* ]]; then
    indices=($(echo "$@" | ruby --disable=gems $ZSH_GIT_SCRIPTS_DIR/lib/__expand_range.rb))
  else
    indices=($@)
  fi

  # Each space separated argument
  for x in $indices; do
    local filename=$_git_indices[$x]

    if [ "$filename" = "" ];then
      result+=($x)
    else
      result+=($filename)
    fi
  done

  echo $result
}
