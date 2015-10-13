#!/bin/bash

# Try to start tray applications.
nm-applet &
cbatticon -n &
insync start &
screencloud &

# Try to start Ubuntu specific deamons.
if [ 'python -mplatform | grep Ubuntu' ]; then
    echo 'Start Ubuntu deamons'
    unity-settings-daemon &
    /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
fi

# Detect the names of connected screens.
outputs=($(xrandr | grep ' connected' | cut -d ' ' -f1))
for i in "${!outputs[@]}"; do
    echo "Output $i: ${outputs[$i]}"
done

# Three screens are my desktop layout.
if [ ${#outputs[@]} = "3" ]; then
    i3-msg "workspace 1;
        move workspace to output ${outputs[2]};
        exec urxvtcd; exec urxvtcd"
    i3-msg "workspace 2;
        move workspace to output ${outputs[2]};
        exec urxvtcd; exec urxvtcd"
    i3-msg "workspace 4;
        move workspace to output ${outputs[1]};
        exec urxvtcd; exec urxvtcd"
    i3-msg "workspace 5;
        move workspace to output ${outputs[1]};
        exec urxvtcd; exec urxvtcd"
    i3-msg "workspace 3;
        move workspace to output ${outputs[0]};
        exec --no-startup-id google-chrome-stable"

# One screen is my laptop layout.
elif [ ${#outputs[@]} = "1" ]; then
    i3-msg "workspace 1;
        exec urxvtcd; exec urxvtcd"
    i3-msg "workspace 2;
        exec urxvtcd; exec urxvtcd"
    i3-msg "workspace 3;
        exec --no-startup-id google-chrome-stable"
fi
