#!/bin/bash
# Fetch xorg colors and export them as environment variables.

color () {
    line=$(xrdb -q | egrep $1 | head -n 1)
    color=$(echo $line | egrep -o "#.*$" | egrep -o "[A-Za-z0-9]*")
    echo $color
}

export COLOR_FG="$(color foreground)"
export COLOR_BG="$(color background)"
export COLOR_00="$(color color0)"
export COLOR_01="$(color color1)"
export COLOR_02="$(color color2)"
export COLOR_03="$(color color3)"
export COLOR_04="$(color color4)"
export COLOR_05="$(color color5)"
export COLOR_06="$(color color6)"
export COLOR_07="$(color color7)"
export COLOR_08="$(color color8)"
export COLOR_09="$(color color9)"
export COLOR_10="$(color color10)"
export COLOR_11="$(color color11)"
export COLOR_12="$(color color12)"
export COLOR_13="$(color color13)"
export COLOR_14="$(color color14)"
export COLOR_15="$(color color15)"
