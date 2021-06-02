#!/bin/sh

tmux -f /dev/null -L temp start-server \; list-keys | \
    sed -r \
    -e "s/(bind-key.*\s+)([\"#~\$])(\s+)/\1\'\2\'\3/g" \
    -e "s/(bind-key.*\s+)([\'])(\s+)/\1\"\2\"\3/g" \
    -e "s/(bind-key.*\s+)([;])(\s+)/\1\\\\\2\3/g" \
    -e "s/(command-prompt -I )#([SW])/\1\"#\2\"/g" \
    -e "s/(if-shell -F -t = )#([^ ]+)/\1\"#\2\"/g" \
    > ~/.tmux.defaults.conf
