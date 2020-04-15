# My scripts for git

These are scripts that make it easier for me to use git.

I have the following scripts:

* `git_choose_branch`
* `git_choose_remote_branch`

These allow using fzf to switch to local resp. remote branches.

## Prerequisites

* zsh
* oh-my-zsh
* fzf

## Installation

Clone this repository into the `$ZSH_CUSTOM/plugins` directory and add the plugin to the
oh-my-zsh plugins list.

## Usage

Add bindkey statements for both scripts, for example:

```
# Bind <Esc>r (and alt-r) to 'git_choose_branch' (git branch)
bindkey '\er' _git_choose_branch
# Bind <Esc>R (and alt-shift-r) to 'gbrr' (git branch --remote)
bindkey '\eR' _git_choose_remote_branch
```
