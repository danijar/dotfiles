#!/bin/sh
# Startup script for startx.

# Run Xorg user startup script.
[[ -f ~/.xprofile ]] && . ~/.xprofile

# Start window manager.
exec i3
