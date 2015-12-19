[[ -e ~/.profile ]] && emulate sh -c "source ~/.profile"

# Enable command completion
autoload -U compinit && compinit

# Key bindings
bindkey "^R" history-incremental-search-backward

# Sync history immediately
SAVEHIST=100
HISTFILE=~/.zsh_history
setopt inc_append_history share_history

# Include Z
. ~/.script/z.sh

# Vim commands
bindkey -v
export KEYTIMEOUT=1

# Left prompt
PS1="%B%F{black}"
PS1+="%K{green} %n %k"
PS1+="%K{yellow} %~ %k"
PS1+="%k%f%b "

# Enable version control status
autoload -Uz vcs_info
zstyle ":vcs_info:git:*" formats "%b"
setopt prompt_subst
precmd() { vcs_info }

# Disable default virtualenv info
VIRTUAL_ENV_DISABLE_PROMPT=1

# Right prompt
function right_prompt {
    RPROMPT="%B%F{black}%K{yellow} "
    # Version control status
    if [ $vcs_info_msg_0_ ]; then
        RPROMPT+="$vcs_info_msg_0_ "
    fi
    # Virtualenv
    if [ $VIRTUAL_ENV ]; then
        RPROMPT+="venv "
    fi
    # Editing mode
    RPROMPT+="%K{green} "
    if [ "$KEYMAP" = "vicmd" ]; then
        RPROMPT+="normal "
    elif [ "$KEYMAP" = "main" ]; then
        RPROMPT+="insert "
    fi
}

ZLE_RPROMPT_INDENT=0
right_prompt
function zle-line-init zle-keymap-select {
    right_prompt
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
