#!/bin/zsh

# Show a list of remote branches and check them out as local tracking branches

# E.g.:
#   user chooses `origin/team/feature-branch`
#   => `git switch team/feature-branch`

set -o pipefail

_zsh_git_scripts_git_choose_remote_branch () {
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
        LBUFFER="git switch $branch_name"
      else
        # Branch does not exist locally, check it out as a tracking branch
        LBUFFER="git switch --create $branch_name --track origin/$branch_name"
      fi
    else
      LBUFFER="$LBUFFER origin/$branch_name"
    fi
  fi
}

zle -N _zsh_git_scripts_git_choose_remote_branch{,}
