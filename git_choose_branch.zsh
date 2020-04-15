#!/bin/zsh

set -o pipefail

_git_choose_branch () {
  local chosen_branch=$(recent_checkouts.rb | fzf)

  if [[ "$?" = "0" ]]; then
    local branch_name=$(echo $chosen_branch | awk '{ print $1; }')
    LBUFFER="git checkout $branch_name "
  else
    echo "Nothing chosen"
  fi
}

zle -N _git_choose_branch{,}
bindkey '\er' _git_choose_branch
