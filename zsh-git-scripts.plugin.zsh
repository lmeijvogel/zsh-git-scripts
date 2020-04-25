export ZSH_GIT_SCRIPTS_DIR=$(/bin/readlink -f ${0%/*})

source $ZSH_GIT_SCRIPTS_DIR/__convert_indices.zsh
source $ZSH_GIT_SCRIPTS_DIR/git_choose_branch.zsh
source $ZSH_GIT_SCRIPTS_DIR/git_choose_remote_branch.zsh
source $ZSH_GIT_SCRIPTS_DIR/expand_indices.zsh
source $ZSH_GIT_SCRIPTS_DIR/git-add.zsh
source $ZSH_GIT_SCRIPTS_DIR/git-diff.zsh
source $ZSH_GIT_SCRIPTS_DIR/git-status.zsh
