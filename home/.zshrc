[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

# Prompt
PS1='%F{green}%n%f %B%F{blue}%~%f %F{green}$%f%b '

# Include Z
. ~/.script/z.sh
