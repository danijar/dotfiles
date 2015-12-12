[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

# Enable command completion
autoload -U compinit && compinit

# Prompt
PS1='%B%F{green}%n%f %F{blue}%~%f %F{green}$%f%b '

# Key bindings
bindkey '^R' history-incremental-search-backward

# Sync history immediately
setopt inc_append_history
setopt share_history

# Include Z
. ~/.script/z.sh
