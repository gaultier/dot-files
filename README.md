
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
```

- `sudo chsh -s /usr/bin/zsh pg`


How to: https://www.atlassian.com/git/tutorials/dotfiles
