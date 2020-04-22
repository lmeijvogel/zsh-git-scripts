#!/bin/zsh

# Show a list of remote branches and check them out as local tracking branches

# E.g.:
#   user chooses `origin/team/feature-branch`
#   => `git checkout team/feature-branch`

set -o pipefail

_git_choose_remote_branch () {
  local chosen_ref=$(git for-each-ref --format "%(refname:short)" refs/remotes/origin | grep -v "HEAD$" | fzf)

  if [[ "$chosen_ref" = "" ]]; then
    # Do nothing
  else
    local branch_name=$(echo $chosen_ref | sed -E 's/[^/]+\///')

    if [ "$LBUFFER" == "" ]; then
      # Check whether the branch already exists locally
      git show-ref --verify --quiet "refs/heads/$branch_name"

      if [ "$?" = "0" ]; then
        # Branch already exists locally, just check it out
        LBUFFER="git checkout $branch_name"
      else
        # Branch does not exist locally, check it out as a tracking branch
        LBUFFER="git checkout -b $branch_name --track origin/$branch_name"
      fi
    else
      LBUFFER="$LBUFFER $branch_name"
    fi
  fi
}

zle -N _git_choose_remote_branch{,}
bindkey '\eR' _git_choose_remote_branch
