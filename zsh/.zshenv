#!/bin/zsh
#
# order: 
# .zshenv → .zprofile → .zshrc → .zlogin → .zlogout
#
# .zshenv: sourced both for interactive and non interactive shells 

FILENAME=${0:A:h}
export DOTFILES=$(readlink -e "$HOME/.zshenv" | xargs dirname | xargs dirname)
export ZDOTDIR="${DOTFILES}/zsh"

export LC_ALL=en_US.UTF-8

[ -d  "$HOME/bin" ] && PATH="$PATH:$HOME/bin"
[ -d  "$HOME/.local/bin" ] && PATH="$PATH:$HOME/.local/bin"

# support for compdef (completions for zsh)
autoload -Uz compinit
compinit -d $HOME/.cache/.zcompdump-$HOST
compinit -u

for f in $DOTFILES/**/env.zsh; do 
  . "$f"
done

# zstyle ':completion:*' completer _expand _complete _ignored
# zstyle :compinstall filename '/home/lex/.zshrc'

# lightdm does not source .zprofile :(
# use this fix for now
if [[ ! -f "/tmp/.zprofiled" ]]; then
  touch /tmp/.zprofiled
  . /etc/profile
  . $ZDOTDIR/.zprofile
  for f in $DOTFILES/**/zprofile.zsh; do 
    . "$f"
  done
fi
