if ! [ -f $HOME/.zshenv ];then 
  echo Installing ~/.zshenv
  DOTFILES=$(readlink -e "$HOME/.zshrc" | xargs dirname | xargs dirname)
  ln -s $DOTFILES/zsh/.zshenv $HOME/
  source $HOME/.zshenv
fi

export GDK_SCALE=0.5
export GDK_DPI_SCALE=2

[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local

source $DOTFILES/zplug/preinit.zsh

# display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"
# hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

stty start undef  # disable C-s stopping receiving keyboard signals.
stty stop undef
setopt MENU_COMPLETE  # select first menu option automatically
setopt NO_NOMATCH  # stop zsh from catching ^ chars.
setopt PROMPT_SUBST  # prompt substitution
setopt AUTO_CONTINUE

 # caps lock = control key
 # re-run this when plugging in another keyboard
 type setxkbmap > /dev/null 2>&1 && setxkbmap -option ctrl:nocaps

# # fix rider showing on Wayland
# export _JAVA_AWT_WM_NONREPARENTING=1

rm -f ~/.zcompdump*

# after entering repeat command like !-2, press space to auto-expand the command
bindkey ' ' magic-space

export HISTCONTROL=ignoreboth:erasedups
HISTSIZE=10000000
SAVEHIST=10000000
# setopt BANG_HIST                 # Treat the '!' character specially during expansion.
# setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
# setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
# setopt SHARE_HISTORY             # Share history between all sessions.
# setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
# setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
# setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
# setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
# setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
# setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
# setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
# setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
# setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# # The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# for clipboard sharing with host
if type vmware-user 1>/dev/null; then
  vmware-user --no-startup-d
fi

if type fortune 1>/dev/null; then
  fortune | cowsay -f meow | xargs -0 echo -e "     $(date "+ %A %e %B %R Week %V")\n" 
fi

if type prettyping 1>/dev/null; then
  alias ping='prettyping'
fi

for f in $DOTFILES/**/init.zsh; do 
  source "$f"
done

if ! zplug check; then
  printf "Run zplug install? [y/N]: "
  if read -q; then
      echo; zplug install
  else
      echo
  fi
fi
zplug load # --verbose

for f in $DOTFILES/**/postinit.zsh; do 
  source "$f"
done

# have to place here at the end because grep is aliassed by ohmyzsh
alias grep="grep -iF --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}"

unalias ll || true
unalias l || true
if type lsd 1>/dev/null; then
  alias l="lsd -la"
else 
  if type exa 1>/dev/null; then
    alias la="exa -albgh"
    alias l="exa -alFbgh"
  else
    alias l="ls -laFh"
  fi
fi

if type duf 1>/dev/null; then
  alias df="duf"
fi

# execute auto suggestion with CTRL E
bindkey "^E" autosuggest-execute
bindkey "^F" forward-word

# cd into working directory
cwd
