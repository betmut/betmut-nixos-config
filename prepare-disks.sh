#!/usr/bin/env bash
set -euo pipefail

BOOT_PARTITION=""
SWAP_PARTITION=""
ROOT_PARTITION=""

usage() {
    echo "Usage: $0 -b|--boot <partition> -r|--root <partition> [-s|--swap <partition>]"
    echo "  -b, --boot    Path to boot partition (e.g., /dev/nvme0n1p1) [Required]"
    echo "  -r, --root    Path to root partition (e.g., /dev/nvme0n1p3) [Required]"
    echo "  -s, --swap    Path to swap partition (e.g., /dev/nvme0n1p2) [Optional]"
    echo "  -h, --help    Show this help message"
    exit 1
}

# Parse short and long arguments manually
while [[ $# -gt 0 ]]; do
    case "$1" in
        -b|--boot)
            BOOT_PARTITION="$2"
            shift 2
            ;;
        -r|--root)
            ROOT_PARTITION="$2"
            shift 2
            ;;
        -s|--swap)
            SWAP_PARTITION="$2"
            shift 2
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Error: Unknown argument: $1" >&2
            usage
            ;;
    esac
done

# Ensure required arguments are provided
if [[ -z "$BOOT_PARTITION" || -z "$ROOT_PARTITION" ]]; then
    echo "Error: Missing required partition arguments (--boot and --root are required)." >&2
    usage
fi

# ==================== WARNING & CONFIRMATION ====================
cat <<EOF

============================================================
                        WARNING
============================================================
This script will IRREVERSIBLY FORMAT and DESTROY ALL DATA on:
  • Boot Partition: $BOOT_PARTITION
  • Root Partition: $ROOT_PARTITION
  • Swap Partition: ${SWAP_PARTITION:-[None provided]}
============================================================

EOF

read -rp "Are you absolutely sure you want to proceed? (Type 'yes' to continue): " CONFIRMATION

if [[ "$CONFIRMATION" != "yes" ]]; then
    echo "Operation aborted by user. No disks were modified."
    exit 0
fi
# ================================================================

# Formatting and labeling boot partition 
echo "Formatting and labeling boot partition..."
mkfs.fat -F 32 "$BOOT_PARTITION"
fatlabel "$BOOT_PARTITION" NIXOS_BOOT

# Formatting and labeling root partition
echo "Formatting and labeling root partition..."
mkfs.ext4 -L NIXOS_ROOT "$ROOT_PARTITION"

# Formatting and labeling swap partition (only if provided)
if [[ -n "$SWAP_PARTITION" ]]; then
    echo "Formatting and labeling swap partition..."
    mkswap -L NIXOS_SWAP "$SWAP_PARTITION"
fi

# Mounting the partitions
echo "Mounting the partitions..."
mount "$ROOT_PARTITION" /mnt
mount --mkdir "$BOOT_PARTITION" /mnt/boot

# Enabling swap (only if provided)
if [[ -n "$SWAP_PARTITION" ]]; then
    echo "Enabling swap..."
    swapon "$SWAP_PARTITION"
fi

echo "Done!"