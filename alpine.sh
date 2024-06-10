doas apk add sway swaylock swayidle neovim curl ripgrep linux-firmware fish kitty jq git mpv networkmanager iwd dbus mandoc fzf fd build-base

doas setup-desktop gnome
doas chsh -s $(which fish) $(whoami)

# Wifi
doas setup-devd udev
doas rc-service iwd start
doas rc-update iwd default
doas rc-service networkmanager start
doas sh -c 'echo "[device]\nwifi.backend=iwd" > /etc/NetworkManager/NetworkManager.conf'
doas rc-update add networkmanager default
doas adduser $(whoami) plugdev
