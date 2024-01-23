#!/bin/zsh

set -o pipefail

_zsh_git_scripts_git_copy_file () {
  local chosen_file=$(git status --porcelain | ruby $ZSH_GIT_SCRIPTS_DIR/lib/sort_status_files.rb | fzf)

  if [[ "$chosen_file" = "" ]]; then
    # do nothing
  else
    local file_name=$(echo $chosen_file | awk '{ print $2; }')

    file_name="$(git rev-parse --show-cdup)$file_name"

    echo $file_name | clipcopy
  fi
}
_zsh_git_scripts_git_choose_file () {
  local chosen_file=$(git status --porcelain | ruby $ZSH_GIT_SCRIPTS_DIR/lib/sort_status_files.rb | fzf)

  if [[ "$chosen_file" = "" ]]; then
    # do nothing
  else
    local file_name=$(echo $chosen_file | awk '{ print $2; }')

    file_name="$(git rev-parse --show-cdup)$file_name"

    # Always add, to edit, just type 'vim' first
    if [ "$LBUFFER" == "" ]; then
      LBUFFER="git add $file_name"
    else
      LBUFFER="$LBUFFER $file_name"
    fi
  fi
}

zle -N _zsh_git_scripts_git_choose_file{,}
zle -N _zsh_git_scripts_git_copy_file{,}
