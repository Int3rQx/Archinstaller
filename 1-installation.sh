#!/bin/bash

# ------------------------------------------------------
# Enter partition names
# ------------------------------------------------------
lsblk
read -p "Enter the name of the EFI  partition (eg. nvme0n1p1): " sda1
read -p "Enter the name of the SWAP partition (eg. nvme0n1p2): " sda2
read -p "Enter the name of the ROOT partition (eg. nvme0n1p3): " sda3

# ------------------------------------------------------
# Sync time
# ------------------------------------------------------
timedatectl set-ntp true

# ------------------------------------------------------
# Format partitions
# ------------------------------------------------------
mkfs.fat -F 32 /dev/$sda1;
mkswap /dev/$sda2
swapon /dev/$sda2
mkfs.btrfs -f /dev/$sda3

# ------------------------------------------------------
# Mount points for btrfs
# ------------------------------------------------------
mount /dev/$sda3 /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@log
btrfs su cr /mnt/@cache
btrfs su cr /mnt/@snapshots
umount /mnt

mount -o noatime,compress=zstd:1,subvol=@ /dev/$sda3 /mnt
mkdir -p /mnt/{boot/efi,home,var/log,var/cache,.snapshots}
mount -o noatime,compress=zstd:1,subvol=@home /dev/$sda3 /mnt/home
mount -o noatime,compress=zstd:1,subvol=@log /dev/$sda3 /mnt/var/log
mount -o noatime,compress=zstd:1,subvol=@cache /dev/$sda3 /mnt/var/cache
mount -o noatime,compress=zstd:1,subvol=@snapshots /dev/$sda3 /mnt/.snapshots
mount /dev/$sda1 /mnt/boot/efi

# ------------------------------------------------------
# Install base packages
# ------------------------------------------------------
pacstrap -K /mnt base base-devel git linux linux-firmware vim openssh reflector rsync amd-ucode

# ------------------------------------------------------
# Generate fstab
# ------------------------------------------------------
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab

# ------------------------------------------------------
# Copy Files to mnt
# ------------------------------------------------------
cp -r Archinstaller /mnt
arch-chroot /mnt