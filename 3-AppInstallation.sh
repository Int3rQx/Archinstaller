#!/bin/bash

# Update user dirs
xdg-user-dirs-update

# Clone yay AUR helper
cd "$HOME/Downloads" || exit
git clone https://aur.archlinux.org/yay-git.git
cd yay-git || exit
makepkg -si --noconfirm

# Install packages via yay
yay --noconfirm -S zram-generator timeshift preload

# Install flatpak
sudo pacman --noconfirm -S flatpak

# Install Spotify via Flatpak
flatpak install -y flathub com.spotify.Client

# Optional: Run SpotX script (use at your own risk)
bash <(curl -sSL https://spotx-official.github.io/run.sh)
