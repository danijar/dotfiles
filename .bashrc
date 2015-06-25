#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Unix tool shortcuts
alias ls='ls --color=auto'
alias l='ls -lh --color=auto --group-directories-first'

# Backup shortcuts
alias backup-pacman='pacman -Qe > ~/.backup/pacman-installed-packages'

# Git shortcuts
alias gs='git status'
alias gl='git log'
alias ga='git add -A'
alias gc='git commit -m '

# Workflow shortcuts
alias x='exit'
alias sp='sudo pacman'
alias va='source bin/activate'
alias vd='deactivate'
alias cl='clear'
alias home='cd ~'

# Default versions
alias subl='subl3'
alias chrome='google-chrome-stable'

# Current projects
alias km='cd ~/repository/seminar-knowledge-mining && source bin/activate'

# List contents after changing directory
function cd()
{
    builtin cd "$*" && ls --group-directories-first -A
}

#PS1='[\u@\h \W]\$ '
PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'

# Enable tab completion
if [ -f /etc/bash_completion ]; then
    /etc/bash_completion
fi
