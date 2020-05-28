# zsh-git-scripts

## Introduction

These are scripts that make it easier (for me :D) to use git.

I have the following scripts:

* `_zsh_git_scripts_git_choose_branch`
* `_zsh_git_scripts_git_choose_remote_branch`

* Numbered git status
* Numbered git log
* Numbered git diff (--cached)

* `ga` git add with numbers support.

The `_zsh_git_scripts_git_choose_*` scripts allow using fzf to switch to local resp. remote branches.

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
bindkey '\er' __zsh_git_scripts_git_choose_branch
# Bind <Esc>R (and alt-shift-r) to 'git_choose_remote_branch'
bindkey '\eR' __zsh_git_scripts_git_choose_remote_branch
# Bind <Esc>x (and alt-x) to 'expand_indices'
bindkey '\ex' __zsh_git_scripts_expand_indices
```

The `choose_branch` functions are intelligent enough that they either:

* Append the chosen branch to the command line when there is already some text, or
* Fill the command line with `git checkout <branch>` if the command line was empty

In the second case, `choose_remote_branch` will also check whether the chosen
branch already exists. If not, it creates a local tracking branch.

Also, add an alias or a keybinding to for the numbered git commands,

for example, for `numbered-git-status.rb`:

```
alias gs="eval \"\`ruby $ZSH_CUSTOM/plugins/zsh-git-scripts/numbered-git-status.rb\`\""

# or

# Bind <Esc>s (and alt-s) to show the numbered git status
bindkey -s '\es' "eval \"\`ruby $ZSH_CUSTOM/plugins/zsh-git-scripts/numbered-git-status.rb\`\"\n"

# Bind _git_add to some thing easier.
alias ga=__zsh_git_scripts_git_add
```

The git log scripts are `numbered-git-log.rb` and `numbered-git-log-all.rb`.
the first only shows the latest 10 commits, the second shows all commits.

Some functions automatically expand any given arguments:

* _git_diff
* _git_add

So you can just call `__zsh_git_scripts_git_diff 1 2` without manually calling `__zsh_git_scripts_expand_indices`.

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
