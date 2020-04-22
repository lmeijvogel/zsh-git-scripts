# Will return the given array to the
# corresponding filenames.
#
# Remember to split the result when passing the
# result into a shell command.
function __convert_indices () {
  local result=()

  local indices=()
  if [[ "$@" = *-* ]]; then
    indices=($(echo "$@" | ruby --disable=gems $ZSH_GIT_SCRIPTS_DIR/__expand_range.rb))
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

function __expand_range () {
  if [[ "$1" = *-* ]]; then
    echo $(echo "$1" | ruby --disable=gems -e 'min, max = $stdin.read.strip.split("-") ; puts (min..max).to_a.join(" ")')
  else
    echo $1
  fi
}
