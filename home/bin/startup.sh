#!/bin/sh

# Try to start tray applications.
nm-applet &
cbatticon -n &
insync start &
screencloud &
redshift-gtk &
# compton -b &

# Set wallpaper or color.
hsetroot -solid #000000

# Try to start Ubuntu specific deamons.
if [ 'python -mplatform | grep Ubuntu' ]; then
    unity-settings-daemon &
    /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
fi
