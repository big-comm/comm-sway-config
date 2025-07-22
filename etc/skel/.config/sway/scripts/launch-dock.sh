#!/bin/bash

killall -q nwg-dock

style_dir="$HOME/.config/nwg-dock"
style_file="style.css"

launcher_cmd="$HOME/.config/sway/scripts/toggle_wofi.sh"

args=(
    -i 32
    -mb 10
    -ml 10
    -mr 10
    -x
    -nows
    -s "$style_dir/$style_file"
    -c "$launcher_cmd"
)
sleep 0.5
nwg-dock "${args[@]}" &
