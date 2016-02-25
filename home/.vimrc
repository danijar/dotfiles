set nocompatible

" Install plugin manager automatically
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

Plug 'terryma/vim-multiple-cursors'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/syntastic'
Plug 'Valloric/YouCompleteMe', { 'do': 'python2 install.py' }
Plug 'jnurmine/Zenburn'
Plug 'Raimondi/delimitMate'
Plug 'airblade/vim-gitgutter'
Plug 'davidhalter/jedi-vim'
Plug 'vim-scripts/loremipsum'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'leafgarland/typescript-vim'
Plug 'yaml.vim'
Plug 'Yggdroot/indentLine'
Plug 'nelstrom/vim-visual-star-search'
Plug 'ctrlpvim/ctrlp.vim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editor settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Visual settings
set number
set cursorline
set visualbell
set t_Co=256
colorscheme zenburn
highlight LineNr ctermbg=NONE
highlight CursorLineNr ctermbg=NONE
highlight CursorColumn cterm=None ctermbg=black
" highlight CursorLine cterm=None ctermbg=...

" Only consider case for search strings containing upper case letter
set ignorecase smartcase

" Highlight search matches
set hlsearch incsearch

" Formatting
set tw=79
set formatoptions+=t
set ts=4 sw=4 sts=4
set autoindent
set expandtab
set backspace=indent,eol,start
set formatoptions-=o
au filetype * set formatoptions-=o

" Exit visual mode immediately
set timeoutlen=1000 ttimeoutlen=0

" Scroll so cursor always stays in the center
set scrolloff=100
set sidescrolloff=100

" Autocomplete commands
set wildmode=longest,list
set wildmenu history=250

" Reduce time to wait for key combos
set timeoutlen=300

" Reload when file changed on the disk
set autoread

" Enable mouse support
set mouse=a

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable features
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Command window
:map q: <Nop>

" Command mode
:map Q <Nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Language settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd Filetype cc   setlocal ts=2 sw=2 sts=2
autocmd Filetype h    setlocal ts=2 sw=2 sts=2
autocmd Filetype html setlocal ts=2 sw=2 sts=2
autocmd Filetype css  setlocal ts=2 sw=2 sts=2
autocmd Filetype yaml setlocal ts=2 sw=2 sts=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-multiple-cursors
let g:multi_cursor_exit_from_visual_mode=0
let g:multi_cursor_exit_from_insert_mode=0
let g:multi_cursor_prev_key='<C-S-n>'

" YouCompleteMe
let g:ycm_path_to_python_interpreter='/usr/bin/python2'
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_add_preview_to_completeopt=0
let g:ycm_max_diagnostics_to_display=10
let g:ycm_key_invoke_completion='<C-Space>'
let g:ycm_key_list_select_completion=['<tab>', '<down>', '<c-j>']
let g:ycm_key_list_previous_completion=['<s-tab>', '<up>', '<c-k>']

" jedi-vim
let g:jedi#completions_enabled=0

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_python_flake8_post_args='--ignore=F403'

" Yggdroot/indentLine
let g:indentLine_color_term=244

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Scripts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remove trailing whitespace on save.
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction

nnoremap <silent> <leader>rts :call TrimWhiteSpace()<cr>

autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

" Return to last edit position when opening files.
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     exe "normal! g`\"" |
    \ endif

set viminfo^=%

" Highlight long lines.
match Error /\%81v.\+/

" Remove highlighting on ESC in normal mode.
nnoremap <silent> <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[
