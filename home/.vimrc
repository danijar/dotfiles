set nocompatible

" Vundle package manager
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Plugin 'Valloric/YouCompleteMe'
Plugin 'terryma/vim-multiple-cursors'
" Plugin 'terryma/vim-smooth-scroll'
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
set ts=4 sw=4 sts=4
set autoindent
set expandtab
set backspace=indent,eol,start
autocmd Filetype cc setlocal ts=2 sw=2
autocmd Filetype h  setlocal ts=2 sw=2

" Exit visual mode immediately
set timeoutlen=1000 ttimeoutlen=0

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

" Plugin vim-smooth-scroll
" noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
" noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
" noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
" noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" Plugin vim-multiple-cursors
let g:multi_cursor_exit_from_visual_mode=0
let g:multi_cursor_exit_from_insert_mode=0

" Highlight long lines
function! HighlightTooLongLines()
  highlight def link RightMargin Error
    if &textwidth != 0
      exec ('match RightMargin /\%<' . (&textwidth + 3) . 'v.\%>' . (&textwidth + 1) . 'v/')
  endif
endfunction
augroup highlight_toolong
  au!
  au FileType,BufEnter * call HighlightTooLongLines()
augroup END

" Remove trailing whitespace on save
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction

nnoremap <silent> <Leader>rts :call TrimWhiteSpace()<CR>

autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()
