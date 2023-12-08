
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
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout -f
config config --local status.showUntrackedFiles no

mkdir ~/not-my-code
mkdir ~/my-code
cd ~/not-my-code
git clone https://github.com/ohmyzsh/ohmyzsh.git
cd ohmyzsh
zsh tools/install.sh
config checkout ~/.zshrc
sudo chsh -s /usr/bin/zsh pg
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -es -i NONE -c "PlugInstall" -c "qa"
```

How to: https://www.atlassian.com/git/tutorials/dotfiles
