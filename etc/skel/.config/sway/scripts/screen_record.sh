#!/bin/bash

SYSTEM_LANG=${LANG%%.*}
case "$SYSTEM_LANG" in
    "pt_BR")
        MSG_STOP_RECORDING="   Parar Gravação"
        MSG_CHOOSE_MODE="   Escolha o modo de gravação"
        MSG_REC_ACTIVE="   Gravar Janela Ativa"
        MSG_REC_SELECTION="󰒉   Gravar Seleção"
        MSG_CANCELED="   Cancelado"
        MSG_NO_ACTION="Nenhuma ação foi selecionada."
        MSG_RECORDING_IN_PROGRESS="   Gravação em andamento"
        MSG_RECORDING_STOPPED="   Gravação parada"
        MSG_SAVED="✓   Gravação salva!"
        MSG_FILE="   Arquivo:"
        MSG_ERROR="   Erro"
        MSG_FILE_NOT_FOUND="Arquivo de gravação não encontrado!"
        MSG_NOTIFY_ACTIVE="   Gravando Janela Ativa"
        MSG_NOTIFY_SELECTION="   Gravando Seleção"
        MSG_NOTIFY_STOP="   Pressione a mesma tecla de atalho para parar."
        ;;
    *)
        MSG_STOP_RECORDING="   Stop Recording"
        MSG_CHOOSE_MODE="   Choose recording mode"
        MSG_REC_ACTIVE="    Record Active Window"
        MSG_REC_SELECTION="󰒉   Record Selection"
        MSG_CANCELED="   Canceled"
        MSG_NO_ACTION="No action was selected."
        MSG_RECORDING_IN_PROGRESS="   Recording in progress"
        MSG_RECORDING_STOPPED="   Recording stopped"
        MSG_SAVED="✓   Recording saved!"
        MSG_FILE="   File:"
        MSG_ERROR="   Error"
        MSG_FILE_NOT_FOUND="Recording file not found!"
        MSG_NOTIFY_ACTIVE="    Recording Active Window"
        MSG_NOTIFY_SELECTION="   Recording Selection"
        MSG_NOTIFY_STOP="   Press the same hotkey to stop."
        ;;
esac

TMP_FILE="/tmp/current_sway_recording"

DIR="$(xdg-user-dir VIDEOS)"
mkdir -p "$DIR"

if pgrep -x "wf-recorder" > /dev/null; then
    SELECTION=$(echo -e "$MSG_STOP_RECORDING" | wofi --dmenu --replace -i -p "$MSG_RECORDING_IN_PROGRESS")
    if [[ "$SELECTION" == "$MSG_STOP_RECORDING" ]]; then
        pkill --signal SIGINT wf-recorder
        sleep 2

        if [ -f "$TMP_FILE" ]; then
            SAVED_FILE=$(cat "$TMP_FILE")
            rm "$TMP_FILE"
            
            if [ -f "$SAVED_FILE" ]; then
                notify-send "$MSG_SAVED" "$MSG_FILE $SAVED_FILE" -i "$SAVED_FILE"
            else
                notify-send "$MSG_ERROR" "$MSG_FILE_NOT_FOUND" -u critical
            fi
        else
            notify-send "$MSG_RECORDING_STOPPED"
        fi
    fi
    exit 0
fi

SELECTION=$(echo -e "$MSG_REC_ACTIVE\n$MSG_REC_SELECTION" | wofi --dmenu --replace -i -p "$MSG_CHOOSE_MODE")

FILENAME="$DIR/recording_$(date +'%Y-%m-%d_%H-%M-%S').mp4"

case "$SELECTION" in
    "$MSG_REC_ACTIVE")
        echo "$FILENAME" > "$TMP_FILE"
        GEOMETRY=$(swaymsg -t get_tree | jq -r '.. | select(.focused? and .focused == true) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')
        wf-recorder -g "$GEOMETRY" -f "$FILENAME" &
        notify-send "$MSG_NOTIFY_ACTIVE" "$MSG_NOTIFY_STOP"
        ;;
    "$MSG_REC_SELECTION")
        GEOMETRY=$(slurp)
        if [ -z "$GEOMETRY" ]; then
            notify-send "$MSG_CANCELED" "$MSG_NO_ACTION"
            exit 0
        fi
        echo "$FILENAME" > "$TMP_FILE"
        wf-recorder -g "$GEOMETRY" -f "$FILENAME" &
        notify-send "$MSG_NOTIFY_SELECTION" "$MSG_NOTIFY_STOP"
        ;;
    *)
        notify-send "$MSG_CANCELED" "$MSG_NO_ACTION"
        exit 1
        ;;
esac
