# Env
export PROMPT='%(?..%F{red}✘ %? )%f%F{blue}%B%~%b %(!.#.›) %f'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export VISUAL=nvim
WORDCHARS='~!#$%^&*(){}[]<>?.+;-'
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
export SAVEHIST=100000
export ARCHFLAGS="-arch x86_64"

export REGISTRY_URI=926410074249.dkr.ecr.eu-central-1.amazonaws.com

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/ice/libexec/bin:$PATH"
export PATH="/usr/local/opt/ice/libexec/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/lib:/opt/pkg/lib/"
export LDFLAGS="-L/usr/lib/ -L/usr/local/lib/ -L/opt/pkg/lib"
export CPPFLAGS="-I/usr/include/ -I/usr/local/include -I/opt/pkg/include " 
export C_INCLUDE_PATH="/usr/local/include:/opt/pkg/include"
export CXXFLAGS="$CPPFLAGS"
export CFLAGS="$CPPFLAGS"
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
export CFLAGS="$CPPFLAGS"
export PATH=$PATH:$GOPATH/bin:$HOME/go/bin
export SCCACHE_REDIS="redis://host.docker.internal"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export MANPAGER="nvim -c 'set ft=man' -"

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

bindkey '^[[A' up-line-or-beginning-search # up arrow
bindkey '^[[B' down-line-or-beginning-search # down arrow
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^W' backward-kill-word
bindkey '^Z' kill-word
bindkey '^[[1;5C' forward-word # Ctrl + right arrow
bindkey '^[[1;5D' backward-word # Ctrl + left arrow

# search_history() {
#   local selected num
#   setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
#   selected=( $(fc -rl 1 | awk '{if (!seen[$2]++) {print $0} }' | fzy) )
#   local ret=$?
#   if [ -n "$selected" ]; then
#     num=$selected[1]
#     if [ -n "$num" ]; then
#       zle vi-fetch-history -n $num
#     fi
#   fi
#   zle reset-prompt
#   return $ret
# }
# zle -N search_history
# bindkey '^R' search_history

# search_files() {
#   LBUFFER="${LBUFFER}$(fd -t f | fzy)"
#   local ret=$?
#   zle reset-prompt
#   return $ret
# }
# zle -N search_files
# bindkey '^T' search_files

# Install stuff if not present already
if [ ! -d $HOME/.config/nvim ]; then
    mkdir -p $HOME/.config/nvim
    ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim
fi

if type kubectl > /dev/null ; then 
    source <(kubectl completion zsh);
    alias k=kubectl
    alias knuke="test $(kubectl config current-context) = 'docker-desktop' && kubectl delete po,svc,ingress,configmap,deploy,replicaset,secret,jobs,cronjobs,ns,statefulsets,role,rolebinding,clusterrole --force --all --grace-period 0 --all-namespaces --ignore-not-found --cascade"
fi

if [ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim ]; then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
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
alias fd=fdfind
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
if [ -e /Users/pgaultier/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/pgaultier/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

source /opt/pkg/share/fzf/shell/key-bindings.zsh
