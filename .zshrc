source $HOME/.zprofile

autoload -Uz compinit
compinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

bindkey '^[[A' up-line-or-search # up arrow
bindkey '^[[B' down-line-or-search # down arrow
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^W' backward-kill-word
bindkey '^Z' kill-word
bindkey '^[[1;5C' forward-word # Ctrl + right arrow
bindkey '^[[1;5D' backward-word # Ctrl + left arrow

alias ydl="youtube-dl -f mp4 --restrict-filenames"

if [ kubectl ]; then source <(kubectl completion zsh); fi
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone --depth 1 --recurse https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

alias k=kubectl
alias d=docker
alias dnuke="docker ps | awk 'NR > 1 {print \$1}' | xargs docker stop -t 0"
alias knuke="test $(kubectl config current-context) = 'docker-desktop' && kubectl delete po,svc,ingress,configmap,deploy,replicaset,secret,jobs,cronjobs,ns,statefulsets,role,rolebinding,clusterrole --force --all --grace-period 0 --all-namespaces --ignore-not-found --cascade"
alias e=$EDITOR
alias l='ls -latr'
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias gst='git status'
alias gco='git checkout'
alias gd='git diff'
alias gp='git push'
alias gl='git pull'
alias gsu='git submodule update --init --recursive'
alias gc='git clone --recurse'
alias gb='git branch'
alias -g ...='../..'

