#!/bin/bash

SYSTEM_LANG=${LANG%%.*}

export TOOLTIP_BATTERY="Battery at {capacity}%"
export FORMAT_DISCONNECTED="󰖪 Disconnected"
export TOOLTIP_DISCONNECTED="Disconnected"
export TOOLTIP_VOLUME="Volume at {volume}%"
export TOOLTIP_BT_STATUS="Bluetooth {status}"
export TOOLTIP_BT_CONNECTED="Connected to {device_alias}"
export TOOLTIP_KEYBINDINGS="Show keybindings"
export TOOLTIP_POWER="Power Menu"
export TOOLTIP_UPDATE="Updates"

if [[ "$SYSTEM_LANG" == "pt_BR" ]]; then
    export TOOLTIP_BATTERY="Bateria {capacity}%"
    export FORMAT_DISCONNECTED="󰖪 Desconectado"
    export TOOLTIP_DISCONNECTED="Desconectado"
    export TOOLTIP_VOLUME="Volume {volume}%"
    export TOOLTIP_BT_STATUS="Bluetooth {status}"
    export TOOLTIP_BT_CONNECTED="Conectado a {device_alias}"
    export TOOLTIP_KEYBINDINGS="Atalhos do teclado"
    export TOOLTIP_POWER="Desligar ou Sair"
    export TOOLTIP_UPDATE="Atualizações"
fi