set nocompatible

" Vundle package manager
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Plugin 'Valloric/YouCompleteMe'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'sickill/vim-monokai'
Plugin 'jnurmine/Zenburn'

" Vundle end
call vundle#end()
filetype plugin indent on

" Visual settings
let t_Co=256
syntax on
set number
set cursorline
set visualbell
set ruler
set background=dark
colorscheme zenburn

" Only consider case for search strings containing upper case letter
set ignorecase smartcase

" Highlight search matches
set hlsearch incsearch

" Formatting
set ts=2 sw=2 sts=2
set autoindent
set expandtab
set backspace=indent,eol,start

" Scroll before cursor reaches window border
" set scrolloff=5

" Always scroll so cursor stays in the middle
set scrolloff=100

" Autocomplete commands
set wildmode=longest,list
set wildmenu history=250

" Reload when file changed on the disk
set autoread

" Plugin YouCompleteMe
" let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
