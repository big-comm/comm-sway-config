#!/bin/bash

SYSTEM_LANG=${LANG%%.*}

case "$SYSTEM_LANG" in
    "pt_BR")
        MSG_TITLE="Captura de Tela"
        MSG_SUCCESS="Salva em:"
        MSG_FAIL="Falha ao capturar a tela."
        USAGE_MSG="Uso: $0 [full|select]"
        ;;
    "es_ES" | "es_MX" | "es_AR" | "es_CL" | "es_CO")
        MSG_TITLE="Captura de Pantalla"
        MSG_SUCCESS="Guardada en:"
        MSG_FAIL="Error al capturar la pantalla."
        USAGE_MSG="Uso: $0 [full|select]"
        ;;
    *)
        MSG_TITLE="Screenshot"
        MSG_SUCCESS="Saved to:"
        MSG_FAIL="Failed to take screenshot."
        USAGE_MSG="Usage: $0 [full|select]"
        ;;
esac

PICTURES_DIR=$(xdg-user-dir PICTURES)
mkdir -p "$PICTURES_DIR"

FILENAME="$PICTURES_DIR/screenshot-$(date +'%F-%H-%M-%S').png"

case "$1" in
    "full")
        grim "$FILENAME"
        ;;
    "select")
        grim -g "$(slurp)" "$FILENAME"
        ;;
    *)
        echo "$USAGE_MSG"
        exit 1
        ;;
esac

if [ -f "$FILENAME" ]; then
    notify-send "$MSG_TITLE" "$MSG_SUCCESS $FILENAME" -i "$FILENAME"
else
    notify-send "$MSG_TITLE" "$MSG_FAIL" -u critical
fi
