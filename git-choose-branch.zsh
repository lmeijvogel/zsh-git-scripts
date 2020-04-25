#!/bin/zsh

set -o pipefail

_git_choose_branch () {
  local chosen_branch=$(ruby $ZSH_GIT_SCRIPTS_DIR/lib/branches_ordered_by_checkout_time.rb | fzf)

  if [[ "$chosen_branch" = "" ]]; then
    # do nothing
  else
    local branch_name=$(echo $chosen_branch | awk '{ print $1; }')

    if [ "$LBUFFER" == "" ]; then
      LBUFFER="git checkout $branch_name "
    else
      LBUFFER="$LBUFFER $branch_name"
    fi
  fi
}

zle -N _git_choose_branch{,}
bindkey '\er' _git_choose_branch
