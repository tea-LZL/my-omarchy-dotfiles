#!/bin/bash

# This searches both class and initialClass case-insensitively
mail_apps=$(hyprctl clients -j | jq -r '.[] | 
    select(
        (.class | test("mail.google.com"; "i")) or 
        (.initialClass | test("mail.google.com"; "i"))
    ) | .address')

for addr in $mail_apps; do
    # Use 'address:' to ensure we target the exact window instance
    hyprctl dispatch movetoworkspacesilent special:mail,address:$addr
done
