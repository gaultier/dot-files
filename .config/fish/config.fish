set -U EDITOR nvim
set -U GIT_EDITOR nvim
set -U CMAKE_CXX_COMPILER_LAUNCHER ccache
set -U CMAKE_C_COMPILER_LAUNCHER ccache
set -U DFT_BACKGROUND "light "
set -U ODIN_ROOT "/home/pg/not-my-code/Odin"

set -U BAT_THEME "ansi"
set -U FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'

set GOROOT $HOME/go
set GOPATH $HOME/go-workspace
set PATH /opt/homebrew/bin/ /usr/sbin/ $ODIN_ROOT /home/pg/not-my-code/ols/ ~/.cargo/bin/ ~/go/bin/ /usr/local/go/bin/ /home/pg/.local/bin $PATH

abbr --add e --position command nvim
abbr --add g --position command git
abbr --add gco --position command git checkout
abbr --add gst --position command git status
abbr --add gp --position command git push
abbr --add gcam --position command git commit -am
abbr --add gca --position command git commit -a
abbr --add gl --position command git pull
abbr --add l --position command ls -latr
abbr --add gsu --position command git submodule update --init --recursive
abbr --add gb --position command git branch
abbr --add gc --position command git clone --recurse
abbr --add gd --position command git diff
abbr --add gdft --position command DFT_BACKGROUND=light GIT_EXTERNAL_DIFF=difft git diff
abbr --add gcl --position command git clone --recurse --depth 1
abbr --add d --position command docker
abbr --add k --position command kubectl

function brew_reconcile
    brew bundle install --file=~/Brewfile --cleanup
end

function config
    git --git-dir=$HOME/.cfg/ --work-tree=$HOME $argv
end

function xcopy
    if command --query wl-copy
        wl-copy
    else if command --query xclip
        xclip -i -select clipboard
    else if command --query pbcopy
        pbcopy
    else 
        false
    end
end

function xpaste
    if command --query wl-paste
       wl-paste
    else if command --query xclip
        xclip -o -select clipboard
    else if command --query pbpaste
        pbpaste
    else
        false
    end
end


if type -q gsettings; and test (uname -s) = Linux
    gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape']"
end

function dstop
    docker ps | awk 'NR > 1 {system("docker rm -f " $1)}'
end

function dnuke
    dstop
    docker volume ls | awk 'NR>1{system("docker volume rm -f " $2)}'
end

function gwip
    git add . && git commit -am "[wip]"
end

# Search and Replace.
function snr -a search replace
    sd "$search" "$replace" $(rg -uu "$search" --files-with-matches $argv[-2..-1])
end


if status is-interactive
    # Commands to run in interactive sessions can go here
end
