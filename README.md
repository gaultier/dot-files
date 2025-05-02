
Setup:

```
mkdir ~/.ssh
ssh-keygen -t ed25519 -C 'philigaultier@gmail.com'
sh -c 'eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519'
chsh -s "$(which fish)" "$(whoami)"
```

[Add to Github](https://github.com/settings/ssh/new)

```
fish
cd ~
echo ".cfg" >> ~/.gitignore
git clone --bare git@github.com:gaultier/dot-files.git ~/.cfg
abbr --add config --position command git --git-dir=$HOME/.cfg/ --work-tree=$HOME
git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout -f
git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no
source ~/.config/fish/config.fish

# ctrl + shift + f5 to reload kitty

mkdir ~/not-my-code ~/my-code ~/company-code
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c ":PlugInstall" -c ":qa"
```

How to: https://www.atlassian.com/git/tutorials/dotfiles
