# zsh-git-scripts

## Introduction

These are scripts that make it easier (for me :D) to use git.

I have the following scripts:

* `_zsh_git_scripts_git_choose_branch`
* `_zsh_git_scripts_git_choose_remote_branch`

The `_zsh_git_scripts_git_choose_*` scripts allow using fzf to switch to local resp. remote branches.

## Prerequisites

* zsh
* oh-my-zsh
* ruby
* fzf

## Installation

Clone this repository into the `$ZSH_CUSTOM/plugins` directory and add the plugin to the
oh-my-zsh plugins list.

## Usage

Add bindkey statements for all scripts, for example:

```
# Bind <Esc>r (and alt-r) to 'git_choose_branch'
bindkey '\er' __zsh_git_scripts_git_choose_branch
# Bind <Esc>R (and alt-shift-r) to 'git_choose_remote_branch'
bindkey '\eR' __zsh_git_scripts_git_choose_remote_branch
```

The `choose_branch` functions are intelligent enough that they either:

* Append the chosen branch to the command line when there is already some text, or
* Fill the command line with `git checkout <branch>` if the command line was empty

In the second case, `choose_remote_branch` will also check whether the chosen
branch already exists. If not, it creates a local tracking branch.

The git log scripts are `numbered-git-log.rb` and `numbered-git-log-all.rb`.
the first only shows the latest 10 commits, the second shows all commits.

Calling the scripts with eval is a bit ugly, but I couldn't get it to work with
calling a function, so this will have to do.
