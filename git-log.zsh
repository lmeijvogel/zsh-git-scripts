# Note: This is not called 'gs' because I don't want to interfere
# with user's default aliases.
function _zsh_git_scripts_git_log () {
  eval "`ruby $ZSH_GIT_SCRIPTS_DIR/lib/numbered-git-log.rb`"
}

function _zsh_git_scripts_git_log_all () {
  eval "`ruby $ZSH_GIT_SCRIPTS_DIR/lib/numbered-git-log.rb`"
}
