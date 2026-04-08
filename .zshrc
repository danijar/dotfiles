# Enable command completion
autoload -U compinit && compinit

# Enable text reflow in terminal.
printf '\e[99999;H\n\e[H'

# History
SAVEHIST=10000
HISTSIZE=20000
HISTFILE=~/.zsh_history
setopt share_history
setopt inc_append_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt hist_reduce_blanks

# Vi commands
bindkey -v
export KEYTIMEOUT=1

# Start line editor in command mode.
zle-line-init() { zle vi-cmd-mode; }
zle -N zle-line-init

# Clipboard
clip-yank() {
    zle copy-region-as-kill
    print -rn -- $CUTBUFFER | $HOME/bin/copy
}
zle -N clip-yank
clip-cut() {
    zle kill-region
    print -rn -- $CUTBUFFER | $HOME/bin/copy
}
zle -N clip-cut
clip-paste() {
    PASTE=$($HOME/bin/paste)
    LBUFFER="$LBUFFER${RBUFFER:0:1}"
    RBUFFER="$PASTE${RBUFFER:1:${#RBUFFER}}"
}
zle -N clip-paste
bindkey -M vicmd "y" clip-yank
bindkey -M vicmd "Y" clip-cut
bindkey -M vicmd "p" clip-paste

bindkey -M vicmd "^K" up-history
bindkey -M vicmd "^J" down-history

# Edit command in Vim
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1
autoload vcs_info
precmd() vcs_info
zstyle ":vcs_info:git:*" formats "%b"
setopt promptsubst
(){
    local line
    if [ -n "$SSH_CONNECTION" ]; then
        line='%B%F{black}%K{red}'
    else
        line='%B%F{black}%K{blue}'
    fi
    line+=' %T '
    line+='${vcs_info_msg_0_:+± ${vcs_info_msg_0_} }'
    line+='${VIRTUAL_ENV:+↱ venv }'
    line+='%K{yellow} %~ %k%f%b'
    PS1="$line "
}

# Run interactive scripts in interactive mode.
[[ $- != *i* ]] && return

. ~/profile/aliases
. ~/profile/env
