#!/bin/bash

source "$HOME/.config/waybar/scripts/i18n.sh"

TEMPLATE_CONFIG="$HOME/.config/waybar/config.template.jsonc"
OUTPUT_CONFIG="$HOME/.config/waybar/config.jsonc"

if [ ! -f "$OUTPUT_CONFIG" ] || [ "$TEMPLATE_CONFIG" -nt "$OUTPUT_CONFIG" ]; then
    
    envsubst '
    $TOOLTIP_BATTERY
    $FORMAT_DISCONNECTED
    $TOOLTIP_DISCONNECTED
    $TOOLTIP_VOLUME
    $TOOLTIP_BT_STATUS
    $TOOLTIP_BT_CONNECTED
    $TOOLTIP_KEYBINDINGS
    $TOOLTIP_POWER
    $TOOLTIP_UPDATE
    ' < "$TEMPLATE_CONFIG" > "$OUTPUT_CONFIG"

fi