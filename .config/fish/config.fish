set -U EDITOR nvim
set -U GIT_EDITOR nvim
set -U CMAKE_CXX_COMPILER_LAUNCHER ccache
set -U CMAKE_C_COMPILER_LAUNCHER ccache
set GOPRIVATE "dev.azure.com/advance52/*"
set DFT_BACKGROUND "light "
set -U ODIN_ROOT "/home/pg/not-my-code/Odin"

set BAT_THEME "ansi"
set FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'

set GOROOT $HOME/go
set GOPATH $HOME/go-workspace
set PATH /usr/sbin/ $ODIN_ROOT /home/pg/not-my-code/ols/ ~/.cargo/bin/ ~/go/bin/ /usr/local/go/bin/ /home/pg/.local/bin $PATH

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
abbr --add gcl --position command git clone --recurse --depth 1
abbr --add d --position command docker
abbr --add k --position command kubectl
abbr --add config --position command git --git-dir=$HOME/.cfg/ --work-tree=$HOME
if command --query wl-copy
    abbr --add xcopy --position command wl-copy
else if command --query xclip
    abbr --add xcopy --position command xclip -i -select clipboard
end
if command --query wl-paste
    abbr --add xpaste --position command wl-paste
else if command --query xclip
    abbr --add xpaste --position command xclip -o -select clipboard
end


gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape']"

function dnuke
    docker ps --all | awk 'NR > 1 {system("docker rm -f " $1)}'
    docker volume ls | awk 'NR>1{system("docker volume rm -f " $2)}'
end

function gwip
    git add . && git commit -am "[wip]"
end


if status is-interactive
    # Commands to run in interactive sessions can go here
end
