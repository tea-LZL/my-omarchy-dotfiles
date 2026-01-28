#!/bin/bash

# This searches both class and initialClass case-insensitively
# It looks for "Cider", "Spotify", or "YouTube Music"
music_apps=$(hyprctl clients -j | jq -r '.[] | 
    select(
        (.class | test("cider|spotify|music.youtube.com"; "i")) or 
        (.initialClass | test("cider|spotify"; "i"))
    ) | .address')

for addr in $music_apps; do
    # Use 'address:' to ensure we target the exact window instance
    hyprctl dispatch movetoworkspacesilent special:music,address:$addr
done
