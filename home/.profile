# Workflows

alias cmc='rm CMakeCache.txt && rm -rf CMakeFiles'

alias scandoc='scanimage --resolution 150dpi | \
    convert -resize 1240x1753 -density 150x150 -units PixelsPerInch \
    -quality 90 -level 0,80%,0.3 -'
