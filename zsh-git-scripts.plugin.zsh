export ZSH_GIT_SCRIPTS_DIR=$(/bin/readlink -f ${0%/*})

source $ZSH_GIT_SCRIPTS_DIR/__convert-indices.zsh
source $ZSH_GIT_SCRIPTS_DIR/expand-indices.zsh
source $ZSH_GIT_SCRIPTS_DIR/git-add.zsh
source $ZSH_GIT_SCRIPTS_DIR/git-choose-branch.zsh
source $ZSH_GIT_SCRIPTS_DIR/git-choose-remote-branch.zsh
source $ZSH_GIT_SCRIPTS_DIR/git-diff.zsh
source $ZSH_GIT_SCRIPTS_DIR/git-log.zsh
source $ZSH_GIT_SCRIPTS_DIR/git-status.zsh
