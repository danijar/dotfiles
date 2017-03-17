#!/bin/sh

################################################################
# Startup script for startx, xinit, XDM, SLIM.
################################################################

# Run Xorg startup scripts.
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

# Start window manager.
exec i3
