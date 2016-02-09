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
alias cmc='rm CMakeCache.txt && rm -rf CMakeFiles'
alias scandoc='scanimage --resolution 150dpi | \
    convert -resize 1240x1753 -density 150x150 -units PixelsPerInch \
    -quality 90 -level 0,80%,0.3 -'

# Default versions and programs
alias subl='subl3'
alias chrome='google-chrome-stable'
alias python='python3'
export EDITOR='vim'

# Auto activate and deavtivate virtualenv
function _cd_virtualenv()
{
    DIR='$(pwd -P)'
    if [ -e 'bin/activate' ]; then
        if [ '$VIRTUAL_ENV' != '$PWD' ]; then
            echo 'Enter virtualenv'
            source bin/activate
        fi
    else
        if ! [ -z $VIRTUAL_ENV ]; then
            echo 'Leave virtualenv'
            deactivate
        fi
    fi
}

# List contents after changing the directory
function _cd_ls()
{
    ls --group-directories-first -A
}

# Register functions to after changing the directory
function cd()
{
    builtin cd "$*" && _cd_virtualenv && _cd_ls
}