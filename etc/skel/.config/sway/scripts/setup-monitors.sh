#!/bin/bash

outputs=$(swaymsg -t get_outputs | jq -r '.[] | select(.active) | .name')

laptop_display=""
external_displays=()

for output in $outputs; do
    if [[ "$output" == "eDP-1" || "$output" == "LVDS-1" ]]; then
        laptop_display=$output
    else
        external_displays+=("$output")
    fi
done

if [[ -n "$laptop_display" && ${#external_displays[@]} -eq 0 ]]; then
    swaymsg output "$laptop_display" enable

elif [[ ${#external_displays[@]} -gt 0 ]]; then
    
    if [[ -n "$laptop_display" ]]; then
        swaymsg output "$laptop_display" disable
    fi

    for display in "${external_displays[@]}"; do
        swaymsg output "$display" enable
    done

else
    swaymsg output "*" enable
fi
