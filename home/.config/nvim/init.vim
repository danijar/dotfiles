set nocompatible

" Install plugin manager automatically
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

" General
Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/loremipsum'

" Editing
" Plug 'terryma/vim-multiple-cursors'
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'nelstrom/vim-visual-star-search'

" Code intel
" Plug 'davidhalter/jedi-vim'
Plug 'scrooloose/syntastic'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

" Languages
Plug 'yaml.vim'
Plug 'plasticboy/vim-markdown'
Plug 'asciidoc/vim-asciidoc'

" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'jnurmine/Zenburn'
Plug 'easysid/mod8.vim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set autoread
set clipboard=unnamedplus
set cursorline
set hidden
set hlsearch incsearch
set ignorecase smartcase
set lazyredraw
set nofoldenable
set noswapfile
set number
set ruler
set splitbelow
set splitright
set visualbell
set wildmenu history=250
set wildmode=longest,list
set completeopt-=preview
set viminfo^=%
set timeoutlen=300
set ttimeoutlen=0
set scrolloff=100
set sidescrolloff=100

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keybinds
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Leader key.
map <Space> <Nop>
let mapleader = " "

" Save pressing Shift to enter command mode.
nnoremap ; :

" Use Q to execute default register.
nnoremap Q @q

" Remove highlighting on ESC in normal mode.
nnoremap <silent> <esc> :noh<return><esc>
nnoremap <silent> <C-c> :noh<return><C-c>
nnoremap <esc>^[ <esc>^[

" Disable features.
map q: <Nop>
map Q <Nop>
map <F1> <Nop>
map <esc> <Nop>

" Make visual block mode work with Ctrl+C.
vnoremap <C-c> <Esc>

" Shortcuts.
nnoremap <leader>s :%s//g<left><left>
vnoremap <leader>s :s//g<left><left>
nnoremap <leader>f mzvipgq`z
nnoremap <leader>r :source ~/.config/nvim/init.vim<return>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Formatting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set tw=79
set formatoptions+=t
set ts=4 sw=4 sts=4
set autoindent
set expandtab
set backspace=indent,eol,start
set formatoptions-=o
set nojoinspaces

autocmd filetype * setlocal formatoptions-=o

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-multiple-cursors
" let g:multi_cursor_exit_from_visual_mode=0
" let g:multi_cursor_exit_from_insert_mode=0
" let g:multi_cursor_start_key='<C-n>'
" let g:multi_cursor_start_word_key='g<C-n>'
" let g:multi_cursor_prev_key='<C-S-n>'
" let g:multi_cursor_quit_key='<C-c>'

" YouCompleteMe
let g:ycm_path_to_python_interpreter = '/usr/bin/python2'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_max_diagnostics_to_display = 10
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_key_list_select_completion=['<tab>', '<down>', '<c-j>']
let g:ycm_key_list_previous_completion=['<s-tab>', '<up>', '<c-k>']
let g:ycm_seed_identifiers_with_syntax = 1

" jedi-vim
" let g:jedi#completions_enabled=0

" syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_post_args = '--ignore=F403,E402'

" indentLine
let g:indentLine_color_term=244

" ctrlp.vim
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_user_command = {'types': {
    \ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others']
    \ }, 'fallback': 'find %s -type f'}

" plasticboy/vim-markdown
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_math = 1
let g:vim_markdown_conceal = 0

" morhetz/gruvbox
let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = "soft"
let g:gruvbox_contrast_light = "hard"

" jnurmine/Zenburn
if exists('g:colors_name') && g:colors_name == 'zenburn'
  highlight LineNr ctermbg=NONE
  highlight CursorLineNr ctermbg=NONE
  highlight CursorColumn cterm=None ctermbg=black
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set background=dark
" set background=light
colorscheme gruvbox
" colorscheme zenburn
" colorscheme mod8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Scripts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remove trailing whitespace on save.
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction
autocmd FileWritePre   * :call TrimWhiteSpace()
autocmd FileAppendPre  * :call TrimWhiteSpace()
autocmd FilterWritePre * :call TrimWhiteSpace()
autocmd BufWritePre    * :call TrimWhiteSpace()

" Return to last edit position when opening files.
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \     exe "normal! g`\"" |
  \ endif

" Highlight long lines.
match Error /\%80v.\+/

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Languages
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd BufNewFile, BufFilePre, BufRead *.md set filetype=markdown

autocmd Filetype cc         setlocal ts=2 sw=2 sts=2
autocmd Filetype h          setlocal ts=2 sw=2 sts=2
autocmd Filetype html       setlocal ts=2 sw=2 sts=2
autocmd Filetype css        setlocal ts=2 sw=2 sts=2
autocmd Filetype yaml       setlocal ts=2 sw=2 sts=2
autocmd Filetype proto      setlocal ts=2 sw=2 sts=2
autocmd Filetype scss       setlocal ts=2 sw=2 sts=2
autocmd Filetype vim        setlocal ts=2 sw=2 sts=2
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2

let g:tex_conceal = "agms"
