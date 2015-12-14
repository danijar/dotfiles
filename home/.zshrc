[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

# Enable command completion
autoload -U compinit && compinit

# Prompt
PS1='%B%F{green}%n%f %F{blue}%~%f %F{green}$%f%b '

# Key bindings
bindkey '^R' history-incremental-search-backward

# Sync history immediately
SAVEHIST=100
HISTFILE=~/.zsh_history
setopt inc_append_history share_history

# Include Z
. ~/.script/z.sh
