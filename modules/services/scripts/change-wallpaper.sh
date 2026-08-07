#!/usr/bin/env bash

LIGHT_DIR="$HOME/Wallpaper/light"
DARK_DIR="$HOME/Wallpaper/dark"
MSG=/tmp/wallpaper.txt

# Image URLs for default wallpapers
DARK_IMAGE_URL="https://gruvbox-wallpapers.pages.dev/wallpapers/anime/108948084_p0.png"
LIGHT_IMAGE_URL="https://gruvbox-wallpapers.pages.dev/wallpapers/photography/anna-scarfiello-Pxf5syDVuxQ.jpg"

# Get current time as a 4-digit number (e.g., 0830 for 08:30 AM)
CURRENT_TIME=$(date +%H%M)

# Ensure the directories exist before proceeding
mkdir -p "$LIGHT_DIR" "$DARK_DIR"

# 2. Download light image if LIGHT_DIR is empty
if [ -z "$(ls -A "$LIGHT_DIR")" ]; then
    echo "LIGHT_DIR is empty. Downloading default wallpaper..."
    curl -sSL -o "$LIGHT_DIR/anna-scarfiello.jpg" "$LIGHT_IMAGE_URL"
fi

# 3. Download dark image if DARK_DIR is empty
if [ -z "$(ls -A "$DARK_DIR")" ]; then
    echo "DARK_DIR is empty. Downloading default wallpaper..."
    curl -sSL -o "$DARK_DIR/shooter.png" "$DARK_IMAGE_URL"
fi

# Check if current time is between 06:00 (0600) and 18:00 (1800)
# 10# forces Bash to treat the numbers as base-10 to prevent octal errors on '08' or '09'
if (( 10#$CURRENT_TIME >= 600 && 10#$CURRENT_TIME < 1800 )); then
    waypaper --random --monitor All --backend awww --folder "$LIGHT_DIR" | grep "Sent" > "$MSG"
    notify-send -i "$LIGHT_DIR/$(cat $MSG | awk '{print $6}')" "✨ Day Wallpaper Updated" "$(cat $MSG)"
else
    waypaper --random --monitor All --backend awww --folder "$DARK_DIR" | grep "Sent" > "$MSG"
    notify-send -i "$DARK_DIR/$(cat $MSG | awk '{print $6}')" "✨ Night Wallpaper Updated" "$(cat $MSG)"
fi