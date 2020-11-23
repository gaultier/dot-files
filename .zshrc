# Env
export PROMPT='%(?..%F{red}✘ %? )%f%F{blue}%B%~%b %(!.#.›) %f'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
setopt EXTENDED_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt share_history
setopt extended_history       # record timestamp of command in HISTFILE
unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end
zstyle ':completion:*:*:*:*:*' menu select # highlight current item on tab completion
# hyphen insensitive, case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
export HISTFILE=$HOME/.zsh_history
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export ARCHFLAGS="-arch x86_64"

export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export REGISTRY_URI=926410074249.dkr.ecr.eu-central-1.amazonaws.com

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"
# export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/usr/local/opt/ice/libexec/bin:$PATH"
export PATH="/usr/local/opt/ice/libexec/bin:$PATH"
export LDFLAGS="-L/usr/local/lib -L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/include -I/usr/local/opt/llvm/include" 
export CXXFLAGS="$CPPFLAGS"
export CFLAGS="$CPPFLAGS"
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
export CFLAGS="-I/usr/local/include/"
export PATH=$PATH:$GOPATH/bin:$HOME/go/bin
export SCCACHE_REDIS="redis://host.docker.internal"

# Load autocompletions
autoload -Uz compinit
compinit

 autoload -U up-line-or-beginning-search
 zle -N up-line-or-beginning-search
 autoload -U down-line-or-beginning-search
 zle -N down-line-or-beginning-search

# Set up FZF (Ctrl-T and Ctrl-R)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone --depth 1 --recurse https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim ]; then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# Dot files
if [ ! -d $HOME/.cfg ]; then
    echo ".cfg" >> $HOME/.gitignore
    git clone --bare https://github.com/gaultier/dot-files.git --depth 1 .cfg
    alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    config config --local status.showUntrackedFiles no
    config checkout
fi

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
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
