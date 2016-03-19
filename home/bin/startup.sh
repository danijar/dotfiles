#!/bin/sh

# Run a command in background if it exists.
startup () {
    if hash $1 2> /dev/null; then
        $@ &
    fi
}

# Try to start tray applications.
startup nm-applet
startup cbatticon -n
startup insync start
startup screencloud
startup redshift-gtk

# Set wallpaper or color.
startup hsetroot -solid "#$COLOR_BG"

# Compositor.
startup compton --config ~/.config/compton.conf

# Try to start Ubuntu specific deamons.
if python -mplatform | grep -q Ubuntu; then
    startup unity-settings-daemon &
    startup /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
fi
