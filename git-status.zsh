# Note: This is not called 'gs' because I don't want to interfere
# with user's default aliases.
function _zsh_git_scripts_git_status () {
  eval "`ruby $ZSH_GIT_SCRIPTS_DIR/lib/numbered-git-status.rb`"
}
