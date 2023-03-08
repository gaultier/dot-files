# Env
export GOPRIVATE=bitbucket.org/advance52/*,dev.azure.com/advance52/*
export PROMPT='%(?..%F{red}✘ %? )%f%F{blue}%B%~%b %(!.#.›) %f'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export VISUAL=nvim
export BAT_THEME=gruvbox-light
WORDCHARS='~!#$%^&*(){}[]<>?.+;-_'
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
setopt hist_find_no_dups
setopt hist_ignore_all_dups
unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end
zstyle ':completion:*:*:*:*:*' menu select # highlight current item on tab completion
# hyphen insensitive, case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000000000
export SAVEHIST=1000000000

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/sbin/:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin:$HOME/go/bin
export PATH="/usr/local/opt/python@3.7/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig:/usr/local/opt/curl/lib/pkgconfig:$PKG_CONFIG_PATH"
export C_INCLUDE_PATH=""
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
export SCCACHE_REDIS="redis://host.docker.internal"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Load autocompletions
autoload -Uz compinit
compinit

 autoload -U up-line-or-beginning-search
 zle -N up-line-or-beginning-search
 autoload -U down-line-or-beginning-search
 zle -N down-line-or-beginning-search

# Custom key bindings
# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Fuzzy search of git branch
git-branch-fzf () {
    CMD="git checkout "$(git branch --list --format='%(refname:lstrip=2)' | fzf )""
    echo $CMD
    zle reset-prompt
    eval "$CMD"
}
zle -N git-branch-fzf

bindkey '^B' git-branch-fzf
bindkey '^[[A' up-line-or-beginning-search # up arrow
bindkey '^[[B' down-line-or-beginning-search # down arrow
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^W' backward-kill-word
bindkey '^Z' kill-word
bindkey '^[[1;5C' forward-word # Ctrl + right arrow
bindkey '^[[1;5D' backward-word # Ctrl + left arrow

# Install stuff if not present already
if [ ! -d $HOME/.config/nvim ]; then
    mkdir -p $HOME/.config/nvim
    ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim
fi

# Nuke (local!) kubernetes
if type kubectl > /dev/null ; then 
    source <(kubectl completion zsh);
    alias k=kubectl
    alias knuke="test $(kubectl config current-context) = 'docker-desktop' && kubectl delete po,svc,ingress,configmap,deploy,replicaset,secret,jobs,cronjobs,ns,statefulsets,role,rolebinding,clusterrole --force --all --grace-period 0 --all-namespaces --ignore-not-found --cascade"
fi

# Dot files
# if [ ! -d $HOME/.cfg ]; then
#     echo ".cfg" >> $HOME/.gitignore
#     git clone --bare https://github.com/gaultier/dot-files.git --depth 1 .cfg
#     alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
#     config config --local status.showUntrackedFiles no
#     config checkout
# fi

# Aliases
alias utc=lua -e 'print(os.date("!%Y-%m-%d %H:%M:%SZ", os.time()))'
alias ydl="youtube-dl -f mp4 --restrict-filenames"
alias d=docker
alias dnuke="docker ps | awk 'NR > 1 {print \$1}' | xargs docker stop -t 0"
alias e=$EDITOR
alias l='ls -latr'
alias gst='git status'
alias gsti='git status --ignore-submodules'
alias gco='git checkout'
alias gd='git diff'
alias gp='git push'
alias gl='git pull'
alias gsu='git submodule update --init --recursive'
alias gc='git clone --recurse'
alias gb='git branch'
alias g='git'
alias gcam='git commit -am'
alias gca='git commit -a'
alias gwip='git add .; git commit -am "[wip]"'
alias gcl='git clone --depth 1 --recurse'
alias gpsup='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
alias ...='cd ../..'
if which fdfind >/dev/null 2>&1; then 
  alias fd=fdfind
fi

# Dot files management
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias vim=nvim

[ -f /usr/local/opt/fzf/shell/completion.zsh ] && source /usr/local/opt/fzf/shell/completion.zsh
[ -f /usr/local/opt/fzf/shell/key-bindings.zsh ] && source /usr/local/opt/fzf/shell/key-bindings.zsh

