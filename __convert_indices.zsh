# Will return the given array to the
# corresponding filenames.
#
# Remember to split the result when passing the
# result into a shell command.
function __convert_indices () {
  local result=()

  # Each space separated argument
  for x in $@; do
    # If applicable, expand ranges "1-4" to "1 2 3 4"
    for y in $(__expand_range "$x"); do
      local filename=$_git_indices[$y]

      if [ "$filename" = "" ];then
        result+=($x)
      else
        result+=($filename)
      fi
    done
  done

  echo $result
}

function __expand_range () {
  if [[ "$1" = *-* ]]; then
    echo $(echo "$1" | ruby -e 'min, max = $stdin.read.strip.split("-") ; puts (min..max).to_a.join(" ")')
  else
    echo $1
  fi
}
