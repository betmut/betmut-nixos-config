#!/usr/bin/env bash

art_file="/tmp/spotify_cover.jpg"

# Subscribe to track change events from Spotify
playerctl --player=spotify metadata --format '{{ title }} - {{ artist }}' --follow 2>/dev/null | while read -r track_info; do
    
    # Skip empty lines (e.g. when Spotify closes or stops playing)
    [ -z "$track_info" ] && continue

    # Fetch current album art URL
    art_url=$(playerctl --player=spotify metadata mpris:artUrl 2>/dev/null)

    # Download artwork silently; fallback to system icon on failure
    if [ -n "$art_url" ] && curl -s -f -o "$art_file" "$art_url"; then
        icon_path="$art_file"
    else
        icon_path="spotify"
    fi

    # Dispatch notification
    notify-send -i "$icon_path" "🎧  Spotify - Playing" "$track_info"
done