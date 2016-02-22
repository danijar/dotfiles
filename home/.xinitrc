# Export user scripts directory.
# export PATH=~/bin:$PATH

# X server configuration.
xrdb -merge ~/xresources/main

# Keyboard layout and bindings.
~/bin/keyboard.sh &

# Background applications.
~/bin/startup.sh &

# Start and run window manager.
exec i3
