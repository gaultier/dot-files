```
cd ~
echo ".cfg" >> ~/.gitignore
git clone --bare git@github.com:gaultier/dot-files.git ~/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout -f
config config --local status.showUntrackedFiles no
```


How to: https://www.atlassian.com/git/tutorials/dotfiles
