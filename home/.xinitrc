setxkbmap -layout us -variant altgr-intl -option nodeadkeys
xbindkeys
xmodmap ~/.Xmodmap
xrdb -merge ~/.Xresources
exec i3
