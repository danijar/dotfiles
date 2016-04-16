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

# Use X clipboard
[[ -n $DISPLAY ]] && (( $+commands[xclip] )) && {
  function cutbuffer() { zle .$WIDGET; echo $CUTBUFFER | xclip; }
  function putbuffer() { zle copy-region-as-kill "$(xclip -o)"; zle .$WIDGET; }
  zle_cut_widgets=(vi-backward-delete-char vi-change vi-change-eol
                   vi-change-whole-line vi-delete vi-delete-char vi-kill-eol
                   vi-substitute vi-yank vi-yank-eol)
  zle_put_widgets=(vi-put-after vi-put-before)
  for widget in $zle_cut_widgets; do; zle -N $widget cutbuffer; done
  for widget in $zle_put_widgets; do; zle -N $widget putbuffer; done
}

# Prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1
autoload vcs_info
precmd() vcs_info
zstyle ":vcs_info:git:*" formats "%b"
setopt promptsubst
(){
    local line
    line='%B%F{black}%K{blue} '
    line+='◕ %T '
    line+='${vcs_info_msg_0_:+± ${vcs_info_msg_0_} }'
    line+='${VIRTUAL_ENV:+↱ venv }'
    line+='%K{yellow} %~ %k%f%b'
    PS1="$line $ "
}
