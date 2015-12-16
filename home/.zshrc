[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

# Enable command completion
autoload -U compinit && compinit

# Key bindings
bindkey '^R' history-incremental-search-backward

# Sync history immediately
SAVEHIST=100
HISTFILE=~/.zsh_history
setopt inc_append_history share_history

# Include Z
. ~/.script/z.sh

# Prompt
PS1='%B%K{green}%F{black} %n %f%k'
PS1+='%K{yellow}%F{green}▶%f%k'
PS1+='%K{yellow}%F{black} %~ %f%k'
PS1+='%K{green}%F{yellow}▶%f%k'
PS1+='%K{green}%F{black} $ %f%k'
PS1+='%F{green}%f%b '
