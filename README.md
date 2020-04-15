# zsh-git-scripts

## Introduction

These are scripts that make it easier (for me :D) to use git.

I have the following scripts:

* `git_choose_branch`
* `git_choose_remote_branch`

* Numbered git status

The `git_choose_*` scripts allow using fzf to switch to local resp. remote branches.

Numbered git status is inspired by scm_breeze and adds numbers to the git status files.

It's different from scm_breeze in that it doesn't add aliases or expand indices automatically (yet?).

Instead, it allows manually expanding the indices with a keybinding.

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
bindkey '\er' _git_choose_branch
# Bind <Esc>R (and alt-shift-r) to 'git_choose_remote_branch'
bindkey '\eR' _git_choose_remote_branch
# Bind <Esc>t (and alt-t) to 'expand_indices'
bindkey '\et' _expand_indices
```

Also, add an alias or a keybinding to show the numbered git status:

```
alias gs="eval \"\`ruby $ZSH_CUSTOM/plugins/zsh-git-scripts/numbered-git-status.rb\`\""

# or

# Bind <Esc>s (and alt-s) to show the numbered git status
bindkey -s '\es' "eval \"\`ruby $ZSH_CUSTOM/plugins/zsh-git-scripts/numbered-git-status.rb\`\"\n"
```

### Example usage for the numbered git status:

The `expand_indices` script creates a function that expands any numbers on the
command line with their corresponding value.

So say that you ran the `numbered-git-status.rb` command (with eval) and it had the
following output:

```
$ eval "`ruby number-git-status.rb`"
On branch master
Your branch is ahead of 'origin/master' by 1 commit.

Changes to be committed:
        new file:     [1] first_file

Changes not staged for commit:
        modified:     [2] dir/second_file
```

Now the numbers 1 and 2 are available for expansion, so for example, if you
now type `cat 2 1` and press your keybinding, it will expand to `cat dir/second_file first_file`.

If an unknown number is present (say `cat 3`), it is left alone.

## Tech note

Calling the scripts with eval is a bit ugly, but I couldn't get it to work with
calling a function, so this will have to do.
