# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/

plugins=(
  git 
  extract
  ssh-agent
  vi-mode
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
  kubectl
  colorize
  z
  shrink-path
)

source $ZSH/oh-my-zsh.sh

set -o vi

# execute auto suggestion with CTRL right arrow
bindkey "^[[1;5C" autosuggest-execute

# make sure the autosuggestions color differs from the solarized dark background color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'

# export LANG=en_US.UTF-8

if [ "$(uname)" = "Darwin" ]; then
  VSCODE='/Applications/Visual Studio Code.app/Contents/Resources/app/bin'
  if [ -d "$VSCODE" ]; then
    export PATH="$PATH:$VSCODE"
  fi

  bindkey -v

else
  if type feh 1>/dev/null; then
    feh --slideshow-delay 1800 --bg-tile $HOME/Pictures/backgrounds -z -r -D1800
    # // --bg-fill or --bg-scale?
  fi
  alias open='xdg-open'
  alias python=python3
  
  . z

  # caps lock = control key
  # re-run this when plugging in another keyboard
  setxkbmap -option ctrl:nocaps

  # fix rider showing on Wayland
  export _JAVA_AWT_WM_NONREPARENTING=1
 
  # fix for qutebrowser
  export QT_AUTO_SCREEN_SCALE_FACTOR=1

  if [ -f /usr/local/bin/scale125 ]; then 
    /usr/local/bin/scale125
  fi
fi

# customize prompt
DEFAULT_USER=$USER

prompt_dir() {
 prompt_segment blue white $(shrink_path -f -s)
}

set clipboard=unnamedplus

# after entering repeat command like !-2, press space to auto-expand the command
bindkey ' ' magic-space

bindkey '^l' history-search-backward
bindkey '^k' history-search-forward

export HISTCONTROL=ignoreboth:erasedups

unalias z

z() {
  _z $@ && pwd
}

if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

# for clipboard sharing with host
if type vmware-user 1>/dev/null; then
  vmware-user --no-startup-d
fi

# echo executing vmtoolsd 
# vmtoolsd -n vmusr &

export LC_ALL=en_US.UTF-8

# Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

if type ag 1>/dev/null; then
alias ag='ag --hidden --all-types --ignore-case --one-device --pager "less -R" '
fi
if type batcat 1>/dev/null; then
  alias cat='batcat -p '
fi
alias d="docker "
alias du="du -h --max-depth=1 "
alias dc="docker-compose "
if type fdfind 1>/dev/null; then
  alias fd='fdfind '
  alias fdh='fdfind --hidden --no-ignore '
fi
if type feh 1>/dev/null; then
  # or use --zoom fill
  alias fehfg='nohup feh -zrs --scale-down --image-bg black --slideshow-delay 3600 ~/Pictures/bgsrcpics &'
fi
if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
  alias preview="fzf --preview 'bat --color \"always\" {}'"
  # add support for ctrl+o to open selected file in VS Code
  export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"
  export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore node_modules -g ""'
fi

alias ga="git add ."
alias gap="git add . -p && git status"
alias gba="git branch -a "
alias gc="git checkout "
alias gc-="git checkout -"
alias gca="git commit --amend --no-edit "
alias gcb="git checkout -b "
alias gcp="git cherry-pick "
alias gcm="git commit -m  "
alias gclean="git checkout -- . && git clean -fd ."
alias gd="git diff --word-diff -w "
alias gds="gd --staged --word-diff | git apply --cached --ignore-whitespace --ignore-space-change --unidiff-zero -"
alias gds="git diff --staged --word-diff -w"
alias gra="git rebase --abort "
alias grc="git rebase --continue "
alias grep="grep -i"
alias gs="git status "
alias gsw="git show "
alias gfa="git fetch --all"
alias gp="git push"
alias gpu="git push -u origin \$(git branch | grep \* | cut -d ' ' -f2)"
alias gpf='echo no gpf please'
alias gpforce="git push --force"
alias gpff="git pull --ff-only"
alias gl="git log --max-count=500 --stat --decorate --graph --color --pretty=format:'%C(yellow)%h %C(cyan)%ad %Cgreen%d %Creset%s %C(yellow)%an' --date=short"
alias gls="git log --max-count=500 --decorate --graph --color --pretty=format:'%C(yellow)%h %C(cyan)%ad %Cgreen%d %Creset%s %C(yellow)%an' --date=short"
alias glp="git log -p "
alias gma="git merge --abort "
alias gmc="git merge --continue "
alias gmnc="git merge --no-commit --no-ff "
if type htop 1>/dev/null; then
  alias top="sudo htop" # alias top and fix high sierra bug
fi
alias ll="exa -alFbgh"
alias l="ls -CFh"
alias ka="k --namespace=argo "
alias la="exa -albgh"
alias lps="lpass show -x -G "
if ! type pbcopy 1>/dev/null; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi
if type prettyping 1>/dev/null; then
  alias ping='prettyping'
fi
alias psg="ps -a | grep $1"
alias sudo="sudo -E "
alias tl="tig log"
alias ts="tig status"
alias yrs="yarn run start &"
alias pwd="pwd -L"

# my life is complete now
bindkey 'jj' vi-cmd-mode

# ubuntu terminal window blue background color #0F293C

[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)

if type fortune 1>/dev/null; then
  fortune | cowsay -f meow | xargs -0 echo -e "     $(date "+ %A %e %B Week %V")\n" | lolcat
fi
