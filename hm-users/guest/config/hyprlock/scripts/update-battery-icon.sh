##!/usr/bin/env bash

set -euo pipefail

HYPRLOCK_DIR="$HOME/.config/hypr"
ICON_DIR="$HYPRLOCK_DIR/assets/battery"
CURRENT="$ICON_DIR/battery-status.png"

# Find the first battery device
BATTERY=$(find /sys/class/power_supply -maxdepth 1 -type l -name 'BAT*' | head -n 1)

if [[ -z "$BATTERY" ]]; then
    echo "No battery found." >&2
    exit 1
fi

# Read the battery percentage
status=$(<"$BATTERY/status")
capacity=$(<"$BATTERY/capacity")

case "$capacity" in
    ''|*[!0-9]*)
        echo "Invalid battery capacity: $capacity" >&2
        exit 1
        ;;
esac

if [[ "$status" == "Charging" ]]; then
    icon="battery-charge.png"
elif (( capacity <= 20 )); then
    icon="very-low-battery.png"
elif (( capacity <= 40 )); then
    icon="low-battery.png"
elif (( capacity <= 60 )); then
    icon="half-battery.png"
elif (( capacity <= 80 )); then
    icon="nearly-half-battery.png"
else
    icon="full-battery.png"
fi

ln -sfn "$ICON_DIR/$icon" "$CURRENT"