# Env
export PROMPT='%(?..%F{red}✘ %? )%f%F{blue}%B%~%b %(!.#.❯) %f'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export HISTSIZE=1000000
export ARCHFLAGS="-arch x86_64"

export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export REGISTRY_URI=926410074249.dkr.ecr.eu-central-1.amazonaws.com

export PATH="$HOME/.cargo/bin:$PATH"
export PATH=$PATH:$GOPATH/bin:~/go/bin
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
export CFLAGS="-I/usr/local/include/"

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
bindkey '^[[A' up-line-or-beginning-search # up arrow
bindkey '^[[B' down-line-or-beginning-search # down arrow
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^W' backward-kill-word
bindkey '^Z' kill-word
bindkey '^[[1;5C' forward-word # Ctrl + right arrow
bindkey '^[[1;5D' backward-word # Ctrl + left arrow

# Install stuff if not present already
if [ kubectl ]; then source <(kubectl completion zsh); fi

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
    git clone --bare https://github.com/gaultier/dot-files.git --depth 1
    alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    config config --local status.showUntrackedFiles no
    config checkout
    config reset --hard
fi

# Aliases
alias ydl="youtube-dl -f mp4 --restrict-filenames"
alias k=kubectl
alias d=docker
alias dnuke="docker ps | awk 'NR > 1 {print \$1}' | xargs docker stop -t 0"
alias knuke="test $(kubectl config current-context) = 'docker-desktop' && kubectl delete po,svc,ingress,configmap,deploy,replicaset,secret,jobs,cronjobs,ns,statefulsets,role,rolebinding,clusterrole --force --all --grace-period 0 --all-namespaces --ignore-not-found --cascade"
alias e=$EDITOR
alias l='ls -latr'
alias gst='git status'
alias gco='git checkout'
alias gd='git diff'
alias gp='git push'
alias gl='git pull'
alias gsu='git submodule update --init --recursive'
alias gc='git clone --recurse'
alias gb='git branch'
alias -g ...='../..'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

