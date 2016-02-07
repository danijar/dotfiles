# Path variable
export PATH=~/bin:$PATH

# Keyboard mapping
setxkbmap -layout us -variant altgr-intl -option nodeadkeys -option ctrl:nocaps
xbindkeys
xmodmap ~/.Xmodmap

xrdb -merge ~/.Xresources
exec i3
