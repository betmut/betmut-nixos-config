#!/usr/bin/env bash

# Directories
LIGHT_DIR="$HOME/Wallpaper/light"
DARK_DIR="$HOME/Wallpaper/dark"

# Get current time as a 4-digit number (e.g., 0830 for 08:30 AM)
CURRENT_TIME=$(date +%H%M)

# Check if current time is between 06:00 (0600) and 18:00 (1800)
# 10# forces Bash to treat the numbers as base-10 to prevent octal errors on '08' or '09'
if (( 10#$CURRENT_TIME >= 600 && 10#$CURRENT_TIME < 1800 )); then
    waypaper --random --monitor All --backend awww --folder "$LIGHT_DIR"
else
    waypaper --random --monitor All --backend awww --folder "$DARK_DIR"
fi