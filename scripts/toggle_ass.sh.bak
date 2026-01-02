#!/bin/sh

STATE_FILE="/home/rajveer/.gemini/tmp/1eaa6ca4e3f95f6958e54911eb20c900b404747c31ccb25e4c153376b8733f53/ass_state"

if [ -f "$STATE_FILE" ]; then
    ass -c 100
    rm "$STATE_FILE"
else
    ass -c 80
    touch "$STATE_FILE"
fi
