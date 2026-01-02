#!/bin/sh

DEVICE="asus::kbd_backlight"

current=$(brightnessctl -d "$DEVICE" g)
max=$(brightnessctl -d "$DEVICE" m)

next=$(( (current + 1) % (max + 1) ))

brightnessctl -d "$DEVICE" s $next
