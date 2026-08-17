#!/usr/bin/env bash
set -euo pipefail

BOOT_PARTITION=$1
SWAP_PARTITION=$2
ROOT_PARTITION=$3

# Formatting and labeling boot partition 
echo "Formatting and labeling boot partition..."
mkfs.fat -F 32 "$BOOT_PARTITION"
fatlabel "$BOOT_PARTITION" NIXOS_BOOT

# Formatting and labeling root partition
echo "Formatting and labeling root partition..."
mkfs.ext4 -L NIXOS_ROOT "$ROOT_PARTITION"

# Formatting and labeling swap partition
echo "Formatting and labeling swap partition..."
mkswap -L NIXOS_SWAP "$SWAP_PARTITION"

# Mounting the partitions
echo "Mounting the partitions..."
mount "$ROOT_PARTITION" /mnt
mount --mkdir "$BOOT_PARTITION" /mnt/boot
swapon "$SWAP_PARTITION"

echo "Done!"