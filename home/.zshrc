# Zsh configuration file.
# http://zsh.sourceforge.net/Doc/Release/Options.html

# Enable command completion
autoload -U compinit && compinit

# Enable text reflow in terminal.
printf '\e[99999;H\n\e[H'

# Trick Vim into using all colors even inside tmux.
# export TERM="xterm-256color"
# export TERM="screen-256color"

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

x-yank() {
    zle copy-region-as-kill
    print -rn -- $CUTBUFFER | xclip -sel clipboard
}
zle -N x-yank

x-cut() {
    zle kill-region
    print -rn -- $CUTBUFFER | xclip -sel clipboard
}
zle -N x-cut

x-paste() {
    PASTE=$(xclip -o -sel clipboard)
    LBUFFER="$LBUFFER${RBUFFER:0:1}"
    RBUFFER="$PASTE${RBUFFER:1:${#RBUFFER}}"
}
zle -N x-paste

bindkey -M vicmd "y" x-yank
bindkey -M vicmd "Y" x-cut
bindkey -M vicmd "p" x-paste
bindkey -M vicmd "^K" up-history
bindkey -M vicmd "^J" down-history

autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Start line editor in command mode.
zle-line-init() { zle vi-cmd-mode; }
zle -N zle-line-init

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
for script in ~/autoload/*; do
    . $script;
done

# Start tmux automatically with SSH.
if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
    tmux
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/danijar/download/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/danijar/download/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/danijar/download/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/danijar/download/google-cloud-sdk/completion.zsh.inc'; fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

