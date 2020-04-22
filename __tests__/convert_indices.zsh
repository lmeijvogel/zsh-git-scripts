local current_dir=${0%/*}

. $current_dir/../__convert_indices.zsh

declare -A _git_indices

_git_indices[1]="one"
_git_indices[2]="two"
_git_indices[3]="three"
_git_indices[4]="four"
_git_indices[5]="five"
_git_indices[6]="six"

function perform_test () {
  output=$(__convert_indices $input)
  echo -n "Testing '$input'... "
  if [ "$output" = "$expected" ]; then
    echo "OK"
  else
    echo "ERROR, expected '$output' to equal '$expected'"
  fi
}

input=(1)
expected=(one)
perform_test $input $expected

input=(1 2)
expected=(one two)
perform_test $input $expected

input=(file 1)
expected=(file one)
perform_test $input $expected

input=(3 1-4 6)
expected=(three one two three four six)
perform_test $input $expected

input=(--cached 3 1-4 6)
expected=(--cached three one two three four six)
perform_test $input $expected
