#!/bin/bash

# Detect the names of connected screens.
outputs=($(xrandr | grep ' connected' | cut -d ' ' -f1))
for i in "${!outputs[@]}"; do
    echo "Output $i: ${outputs[$i]}"
done

# Three screens.
if [ ${#outputs[@]} = "3" ]; then
    i3-msg "workspace 1;
        move workspace to output ${outputs[1]};
        exec urxvtcd; exec urxvtcd"
    i3-msg "workspace 3;
        move workspace to output ${outputs[2]};
        exec urxvtcd; exec urxvtcd"
    i3-msg "workspace 2;
        move workspace to output ${outputs[0]};
        exec --no-startup-id google-chrome-stable"

# Two screens.
elif [ ${#outputs[@]} = "2" ]; then
    i3-msg "workspace 2;
        move workspace to output ${outputs[1]};
        exec urxvtcd; exec urxvtcd"
    i3-msg "workspace 1;
        move workspace to output ${outputs[0]};
        exec --no-startup-id google-chrome-stable"

# One screen.
elif [ ${#outputs[@]} = "1" ]; then
    i3-msg "workspace 2;
        exec urxvtcd; exec urxvtcd"
    i3-msg "workspace 1;
        exec --no-startup-id google-chrome-stable"
fi
