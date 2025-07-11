#!/bin/bash
xdg-user-dirs-update &
cd Downloads/
git clone https://aur.archlinux.org/yay-git.git &
wait # Wait for yay to be cloned before proceeding

cd yay-git
makepkg -si &
wait # Wait for yay to be installed before proceeding

yay --noconfirm -S zram-generator &
yay --noconfirm -S timeshift &
yay --noconfirm -S preload &
wait # Wait for all package installs to finish before moving on
