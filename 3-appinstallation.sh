#!/bin/bash

sudo pacman -S --noconfirm plasma sddm kitty kate firefox dolphin exfatprogs btrfs-progs 
sleep 300
xdg-user-dirs-update
cd Downloads/
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si
sleep 120
yay --noconfirm -S zram-generator timeshift preload
sleep 300
flatpak install -y flathub com.spotify.Client
sleep 120
bash <(curl -sSL https://spotx-official.github.io/run.sh)
sleep 60
bash <(curl -s "https://end-4.github.io/dots-hyprland-wiki/setup.sh")