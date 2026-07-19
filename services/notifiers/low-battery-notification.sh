#!/usr/bin/env bash

sleep 1
STATE_FILE="/tmp/battery_last_status"
# Read previous state, default to "Unknown" if file doesn't exist
LAST_STATUS=$(cat "$STATE_FILE" 2>/dev/null || echo "Unknown")

# Get battery level (works on most laptops)
battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
battery_status=$(cat /sys/class/power_supply/BAT0/status)

# Thresholds
LOW=20
CRITICAL=10

if [ "$battery_status" = "Discharging" ]; then
    if [ "$battery_level" -le "$CRITICAL" ]; then
        # -u critical ensures it stays on screen (timeout 0 in your config)
        notify-send -u critical -i "battery-empty" "CRITICAL BATTERY" "Battery at ${battery_level}%. Plug in now\!"
    elif [ "$battery_level" -le "$LOW" ]; then
        # -u normal uses your 8s timeout
        notify-send -u normal -i "battery-caution" "Low Battery" "Battery is at ${battery_level}%."
    fi
elif [ "$battery_status" = "Charging" ] && [ "$LAST_STATUS" != "Charging" ]; then
    # Only notifies if we JUST plugged it in
    notify-send -u normal -i "battery-040-charging" "Charging" "Battery is now charging."
elif [ "$battery_status" = "Discharging" ] && [ "$LAST_STATUS" != "Discharging" ]; then
    notify-send -u normal -i "battery-050" "Discharging" "Battery is now discharging."
fi

# Save the current status for the next 5-minute check
echo "$battery_status" > "$STATE_FILE"