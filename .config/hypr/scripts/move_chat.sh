#!/bin/bash

# This searches both class and initialClass case-insensitively
# It looks for "Cider", "Spotify", or "YouTube chat"
chat_apps=$(hyprctl clients -j | jq -r '.[] | 
    select(
        (.class | test("discord"; "i")) or 
        (.initialClass | test("discord"; "i"))
    ) | .address')

for addr in $chat_apps; do
    # Use 'address:' to ensure we target the exact window instance
    hyprctl dispatch movetoworkspacesilent special:chat,address:$addr
done
