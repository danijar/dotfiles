[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

# Prompt
PS1='%B%F{green}%n%f %F{blue}%~%f %F{green}$%f%b '

# Key bindings
bindkey '^R' history-incremental-search-backward

# Include Z
. ~/.script/z.sh
