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

setopt promptsubst
(){
    local left right invisible lenleft

    # User name.
    left='%B%F{black}%K{green} %n '
    # Current working directory.
    left+='%K{yellow} %~ '
    # Version control branch.
    right='${vcs_info_msg_0_:+${vcs_info_msg_0_//[%]/%%} }'
    # Virtualenv.
    export VIRTUAL_ENV_DISABLE_PROMPT=1
    right+='${VIRTUAL_ENV:+venv }'
    # Editing mode.
    EDITMODE=insert
    right+='%K{green} $EDITMODE'
    right+=$' %k%f%b'

    # Combine left and right prompt with spacing in between.
    invisible='%([BSUbfksu]|([FBK]|){*})'
    lenleft=${(S)left//$~invisible}
    lenright=${(S)right//$~invisible}
    PS1="$left\${(l,COLUMNS-\${#\${(%):-$lenleft$lenright}},)}$right%{"$'\n%}$ '
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
