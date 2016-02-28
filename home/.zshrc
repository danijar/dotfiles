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
. ~/bin/z.sh

# Vi commands
bindkey -v
export KEYTIMEOUT=1

setopt promptsubst
(){
    local line length invisible
    export VIRTUAL_ENV_DISABLE_PROMPT=1
    EDITMODE=insert
    line='%B%F{black}%K{blue} '
    # line+='▶ $EDITMODE '
    line+='◕ %T '
    line+='${vcs_info_msg_0_:+± ${vcs_info_msg_0_} }'
    line+='${VIRTUAL_ENV:+↱ venv }'
    line+='%K{yellow} %~ %k%f%b'
    PS1="$line $ "
}

autoload vcs_info
precmd() vcs_info
zstyle ":vcs_info:git:*" formats "%b"

update-edit-mode() {
    case $KEYMAP in
        (vicmd) EDITMODE=normal;;
        (*) EDITMODE=insert
    esac
    [[ $EDITMODE = $oldmode ]] || zle reset-prompt
}

zle -N zle-keymap-select update-edit-mode
