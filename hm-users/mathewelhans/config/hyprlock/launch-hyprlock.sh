#!/usr/bin/env bash

HYPRLOCK_DIR="$NIXOS_CONFIG/hm-users/mathewelhans/config/hyprlock"
WIFI_ICON="$HYPRLOCK_DIR/assets/wifi/wifi-status.png"

trap 'rm -f -- "$WIFI_ICON"' EXIT

"$HYPRLOCK_DIR/scripts/update-wifi-icon.sh"
hyprlock -c "$HYPRLOCK_DIR/hyprlock.conf"