#!/bin/bash

if pgrep -x "wofi" > /dev/null
then
    pkill -x "wofi"
else
# Config Double Click
    #wofi --show drun --no-actions --insensitive --prompt 'Run' | xargs swaymsg exec --
# Config One Click
    wofi --show drun --no-actions --insensitive --prompt 'Run' --define=single_click=true | xargs swaymsg exec --
fi