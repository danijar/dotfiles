# Zsh configuration file.
# http://zsh.sourceforge.net/Doc/Release/Options.html

# Enable command completion
autoload -U compinit && compinit

# Key bindings
bindkey "^R" history-incremental-search-backward

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

# Run interactive scripts in interactive mode.
[[ $- != *i* ]] && return
for script in ~/autoload/*; do
    . $script;
done
