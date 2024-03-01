
Setup:

```
ssh-keygen -t ed25519 -C 'philigaultier@gmail.com'
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```
- Add to Github.

```
cd ~
echo ".cfg" >> ~/.gitignore
git clone --bare git@github.com:gaultier/dot-files.git ~/.cfg
abbr --add config --position command git --git-dir=$HOME/.cfg/ --work-tree=$HOME
config checkout -f
config config --local status.showUntrackedFiles no
source ~/.config/fish/config.fish
pkill --signal SIGUSR1 kitty

mkdir ~/not-my-code ~/my-code
sudo chsh -s $(which fish) $(whoami)
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c ":PlugInstall" -c ":qa"
```

How to: https://www.atlassian.com/git/tutorials/dotfiles
