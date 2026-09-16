#!/usr/bin/env bash

HYPRLOCK_DIR="$NIXOS_CONFIG/hm-users/mathewelhans/config/hyprlock"
HYPRLOCK_SCRIPTS="$HYPRLOCK_DIR/scripts"
WIFI_ICON="$HYPRLOCK_DIR/assets/wifi/wifi-status.png"
BATTERY_ICON="$HYPRLOCK_DIR/assets/battery/battery-status.png"

trap 'rm -f -- "$WIFI_ICON" "$BATTERY_ICON"' EXIT

#Initialize the scripts first
"$HYPRLOCK_SCRIPTS/update-wifi-icon.sh"
"$HYPRLOCK_SCRIPTS/update-battery-icon.sh"

#run hyprlock
hyprlock -c "$HYPRLOCK_DIR/hyprlock.conf"