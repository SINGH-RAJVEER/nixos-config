#!/bin/sh

DEVICE="asus::kbd_backlight"

while true; do
    current=$(brightnessctl -d "$DEVICE" g)
    
    case $current in
        0) display_percentage=0 ;;
        1) display_percentage=33 ;;
        2) display_percentage=66 ;;
        3) display_percentage=100 ;;
        *) display_percentage="?" ;;
    esac

    echo "{\"text\": \"󰌌   $display_percentage%\"}"

done
