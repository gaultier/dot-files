set -U EDITOR nvim
set -U GIT_EDITOR nvim
set -U CMAKE_CXX_COMPILER_LAUNCHER ccache
set -U CMAKE_C_COMPILER_LAUNCHER ccache
set DFT_BACKGROUND "light "
set -U ODIN_ROOT "/home/pg/not-my-code/Odin"

set BAT_THEME "ansi"
set FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'

set GOROOT $HOME/go
set GOPATH $HOME/go-workspace
set PATH /opt/homebrew/bin/ /usr/sbin/ $ODIN_ROOT /home/pg/not-my-code/ols/ ~/.cargo/bin/ ~/go/bin/ /usr/local/go/bin/ /home/pg/.local/bin $PATH

function e
    nvim $argv
end

function g
    git $argv
end

function gco
    git checkout $argv
end

function gst
    git status $argv
end

function gp
    git push $argv
end

function gcam
    git commit -am $argv
end

function gca
    git commit -a $argv
end

function gl
    git pull $argv
end

function l
    ls -latr $argv
end

function gsu
    git submodule update --init --recursive $argv
end

function gb
    git branch $argv
end

function gc
    git clone --recurse $argv
end

function gd
    git diff $argv
end

function gcl
    git clone --recurse --depth 1 $argv
end

function d
    docker $argv
end

function k
    kubectl $argv
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


if command --query gsettings
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


if status is-interactive
    # Commands to run in interactive sessions can go here
end
