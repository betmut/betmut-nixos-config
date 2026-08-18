#!/usr/bin/env bash
set -euo pipefail

BOOT_PARTITION=""
SWAP_PARTITION=""
ROOT_PARTITION=""

usage() {
    echo "Usage: $0 -b <boot_partition> -s <swap_partition> -r <root_partition>"
    echo "  -b    Path to boot partition (e.g., /dev/nvme0n1p1)"
    echo "  -s    Path to swap partition (e.g., /dev/nvme0n1p2)"
    echo "  -r    Path to root partition (e.g., /dev/nvme0n1p3)"
    echo "  -h    Show this help message"
    exit 1
}

while getopts "b:s:r:h" opt; do
    case "$opt" in
        b) BOOT_PARTITION="$OPTARG" ;;
        s) SWAP_PARTITION="$OPTARG" ;;
        r) ROOT_PARTITION="$OPTARG" ;;
        h) usage ;;
        *) usage ;;
    esac
done

# Ensure all required flags were passed
if [[ -z "$BOOT_PARTITION" || -z "$SWAP_PARTITION" || -z "$ROOT_PARTITION" ]]; then
    echo "Error: Missing required partition arguments." >&2
    usage
fi

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