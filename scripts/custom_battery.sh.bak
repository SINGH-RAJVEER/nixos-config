#!/bin/sh

STATE_FILE="/home/rajveer/.gemini/tmp/1eaa6ca4e3f95f6958e54911eb20c900b404747c31ccb25e4c153376b8733f53/ass_state"
BATTERY=$(ls /sys/class/power_supply/ | grep 'BAT' | head -n 1)

get_icon() {
    local capacity=$1
    local status=$2
    local icons=("󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")

    if [ "$status" = "Charging" ] || [ "$status" = "Plugged" ]; then
        echo "󰂄"
        return
    fi

    if [ "$status" = "Full" ]; then
        echo "󰁹"
        return
    fi

    local index=$((capacity / 10))
    if [ $index -ge ${#icons[@]} ]; then
        index=$((${#icons[@]} - 1))
    fi
    echo "${icons[$index]}"
}


while true; do
    if [ -z "$BATTERY" ]; then
        # No battery found
        echo "{}"
        sleep 60
        continue
    fi

    capacity=$(cat "/sys/class/power_supply/$BATTERY/capacity")
    status=$(cat "/sys/class/power_supply/$BATTERY/status")
    icon=$(get_icon $capacity $status)

    if [ -f "$STATE_FILE" ]; then
        class="state-100"
    else
        class="state-80"
    fi

    # Add capacity attribute for styling
    if [ "$capacity" -eq 100 ]; then
        class="$class capacity-100"
    fi

    echo "{\"text\": \"$icon $capacity%\", \"class\": \"$class\"}"

    sleep 5
done
