#!/bin/bash

killall -q nwg-dock

config_gtk="$HOME/.config/gtk-3.0/settings.ini"
style_dir="$HOME/.config/nwg-dock"
style_file="style.css"

launcher_cmd="wofi --show drun --no-actions --insensitive --prompt 'Run' | xargs swaymsg exec --"

args=(
    -i 32
    -w 5
    -mb 10
    -ml 10
    -mr 10
    -x
    -s "$style_dir/$style_file"
    -c "$launcher_cmd"
)
sleep 0.5
nwg-dock "${args[@]}" &
