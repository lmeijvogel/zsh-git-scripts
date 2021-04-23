#!/usr/bin/zsh

# This calls `git add` with the selected file(s).
#
# It passes command line flags to `git add`, so calling this script with e.g.
# `--patch` will perform a `git add --patch`, as expected.
git status --porcelain \
  | fzf -m --preview "git diff --color=always {-1}" \
  | awk '// { print $2 }'
