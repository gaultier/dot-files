
Setup:

```
mkdir ~/.ssh
ssh-keygen -t ed25519 -C 'philigaultier@gmail.com'
# On macOS: add `--apple-use-keychain` 
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

mkdir ~/not-my-code ~/my-code ~/company-code ~/scratch
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c ":PlugInstall" -c ":qa"
```

How to: https://www.atlassian.com/git/tutorials/dotfiles

## Linux specific setup

Ubuntu: 

```sh
$ awk '! /^#/ {print $1}' < ~/apt.txt | xargs sudo apt install -y
```

## VM specific setup

```
diff --git a/.config/fish/functions/fish_prompt.fish b/.config/fish/functions/fish_prompt.fish
index 933cea3..9150f75 100644
--- a/.config/fish/functions/fish_prompt.fish
+++ b/.config/fish/functions/fish_prompt.fish
@@ -48,6 +48,8 @@ function fish_prompt --description 'Write out the prompt'
     set_color $color_cwd
     # echo -n (prompt_pwd)
     echo -n (date +"%T.%3N") (prompt_pwd)
+    printf '[%s]' (prompt_hostname)
+
     set_color normal
 
     printf '%s ' (fish_vcs_prompt)
```


## Macos specific setup

### Sudo with Touchid

Add this to `/etc/pam.d/sudo_local`:

```
auth       sufficient     pam_tid.so
```

### Cache ssh key passwords (use keychain)

Add this to `~/.ssh/config`:

```
Host *
    UseKeychain yes
```

### Brew
After installing brew and the dotfiles, do:

```
brew bundle install --file=~/Brewfile --cleanup
```

### Neovim

```sh
```
