#!/bin/zsh

set -o pipefail

_git_choose_branch () {
  local chosen_branch=$(recent_checkouts.rb | fzf)

  if [[ "$chosen_branch" = "" ]]; then
    # do nothing
  else
    local branch_name=$(echo $chosen_branch | awk '{ print $1; }')
    LBUFFER="git checkout $branch_name "
  fi
}

zle -N _git_choose_branch{,}
bindkey '\er' _git_choose_branch
