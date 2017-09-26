#!/bin/sh

# Run a command in background if it exists.
startup () {
    if hash $1 2> /dev/null; then
        $@ &
    fi
}

# Try to start tray applications.
startup cbatticon -n
startup insync start
startup screencloud
startup redshift-gtk
startup unclutter
startup volumeicon
startup /usr/share/goobuntu-indicator/goobuntu_indicator.py

# Set wallpaper or color.
startup hsetroot -solid "#$COLOR_BG"

# Compositor.
startup compton --config ~/.config/compton.conf

# Auto-lock screen.
startup xautolock -time 10 -lockaftersleep -locker "i3lock -c '$COLOR_BG'"

# Try to start Ubuntu specific deamons.
if python -mplatform | grep -q Ubuntu; then
    startup unity-settings-daemon
fi
