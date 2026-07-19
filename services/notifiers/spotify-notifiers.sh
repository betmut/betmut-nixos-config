#!/usr/bin/env bash

# This follows the metadata and executes the block every time it changes
playerctl --player=spotify metadata --format '{{title}} - {{artist}}' --follow | while read -r line; do
    # Get the album art URL (Spotify provides this in metadata)
    art_url=$(playerctl --player=spotify metadata mpris:artUrl)
    
    # Send the notification
    notify-send -i "spotify" "Now Playing" "$line"
done