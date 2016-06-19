# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Path variable.
export PATH="$PATH:~/bin"
export PATH="$PATH:~/.gem/ruby/2.3.0/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64"
export CUDA_HOME="/usr/local/cuda"

# Unix tool shortcuts
alias ls='ls --color=auto'
alias l='ls -lhA --color=auto --group-directories-first --time-style long-iso'
alias clip='xclip -selection c'

# Git shortcuts
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log'
alias ga='git add -A'
alias gc='git commit -m '
alias gf='git fetch --all'
alias gr='git rebase'

# Default versions and programs
alias chrome='google-chrome-stable'
if [ -x "$(command -v python3)" ]; then alias python='python3'; fi
if [ -x "$(command -v nvim)" ]; then alias vim='nvim'; fi
if [ -x "$(command -v pip3)" ]; then alias pip='pip3'; fi
export EDITOR='vim'

# Workflow shortcuts
alias cmc='rm CMakeCache.txt && rm -rf CMakeFiles'
alias scandoc='scanimage --resolution 150dpi | \
    convert -resize 1240x1753 -density 150x150 -units PixelsPerInch \
    -quality 90 -level 0,80%,0.3 -'
function convert-preview() {
    ffmpeg -y -i $1 -r 30 -s 1280x720 -b 3M -strict -2 -movflags faststart $2;
}
function loc() {
    extensions=$(IFS=$'|'; echo "$*")
    echo "$extensions"
    find . -type f | egrep -i "*.($extensions)$" | xargs wc -l
}

# Auto activate and deavtivate virtualenv
function _cd_virtualenv() {
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
function _cd_ls() {
    ls --group-directories-first
}

# Register functions to after changing the directory
function cd() {
    builtin cd "$*" && _cd_virtualenv && _cd_ls
}
