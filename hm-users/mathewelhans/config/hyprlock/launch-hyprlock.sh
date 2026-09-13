#!/usr/bin/env bash

HYPRLOCK_PATH="$NIXOS_CONFIG/hm-users/mathewelhans/config/hyprlock"
WIFI_ICON="$HYPRLOCK_PATH/assets/wifi-status.png"

trap 'rm -f -- "$WIFI_ICON"' EXIT

"$HYPRLOCK_PATH/scripts/update-wifi-icon.sh"
hyprlock -c "$HYPRLOCK_PATH/hyprlock.conf"