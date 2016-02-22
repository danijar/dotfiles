#!/bin/sh
# Executed by startx.

# Run xorg user startup script.
[[ -f ~/.xprofile ]] && . ~/.xprofile

# Start window manager.
exec i3
