#!/bin/sh

################################################################
# Startup script for startx, xinit, XDM, SLIM.
################################################################

# Load default configuration.
[ -f /etc/xprofile ] && . /etc/xprofile

# Load user configuration.
[ -f ~/.xprofile ] && . ~/.xprofile

# Start window manager.
exec i3
