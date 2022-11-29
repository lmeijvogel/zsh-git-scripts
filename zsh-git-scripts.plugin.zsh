export ZSH_GIT_SCRIPTS_DIR=$(/bin/readlink -f ${0%/*})

source $ZSH_GIT_SCRIPTS_DIR/git-choose-branch.zsh
source $ZSH_GIT_SCRIPTS_DIR/git-choose-remote-branch.zsh
source $ZSH_GIT_SCRIPTS_DIR/git-log.zsh
