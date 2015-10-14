#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Unix tool shortcuts
alias ls='ls --color=auto'
alias l='ls -lh --color=auto --group-directories-first --time-style long-iso'
alias clip='xclip -selection c'

# Git shortcuts
alias gs='git status'
alias gd='git diff'
alias gds='git diff --stat'
alias gdo='git diff origin/master'
alias gdos='git diff --stat origin/master'
alias gl='git log'
alias ga='git add -A'
alias gc='git commit -m '

# Workflow shortcuts
alias sp='sudo pacman'
alias va='source bin/activate'
alias vd='deactivate'
alias cmc='rm CMakeCache.txt && rm -rf CMakeFiles'
alias scandoc='scanimage --resolution 150dpi | \
    convert -resize 1240x1753 -density 150x150 -units PixelsPerInch \
    -quality 90 -level 0,80%,0.3 -'

# Default versions and programs
alias subl='subl3'
alias chrome='google-chrome-stable'
alias python='python3'
export EDITOR='vim'

# Current projects
alias km='cd ~/repository/seminar-knowledge-mining && source bin/activate'

# List contents after changing directory
function cd()
{
    builtin cd "$*" && ls --group-directories-first -A
}

# Promt
PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'

# Enable tab completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Include Z
. ~/.script/z.sh

