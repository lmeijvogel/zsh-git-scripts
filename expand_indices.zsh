_expand_indices () {
  local sed_expressions=""
  local any_index_found=0

  # I'm using sed here because I can't get zsh variable substitution
  # to work with word boundaries (e.g. it should not change '11' when I only want
  # to replace '1')
  for index git_path in ${(kv)_git_indices}; do
    sed_expressions+=" -e s|\\b$index\\b|$git_path|"
    any_index_found=1
  done

  if [ "$any_index_found" = "1" ]; then
    LBUFFER=$(echo "$LBUFFER" | sed ${=sed_expressions})
  fi
}

zle -N _expand_indices{,}
bindkey '\et' _expand_indices

# Ideally, I'd call a function here that evals the output of number-git-status.rb,
# but I can't get that to work with the _git_indices variable in the global scope.
bindkey -s '\es' 'eval "`ruby ~/projects/git_scripts/number-git-status.rb`"\n'
