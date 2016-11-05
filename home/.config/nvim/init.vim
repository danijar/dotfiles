set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Install plugin manager automatically
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" General
Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/loremipsum'
Plug 'amerlyq/vim-focus-autocmd'
Plug 'tpope/vim-eunuch'

" Editing
" Plug 'terryma/vim-multiple-cursors'
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'nelstrom/vim-visual-star-search'
Plug 'reedes/vim-pencil'

" Code intel
Plug 'Valloric/YouCompleteMe', {'do': './install.py'}
Plug 'bjoernd/vim-ycm-tex'
Plug 'davidhalter/jedi-vim'
Plug 'scrooloose/syntastic'

" Languages
Plug 'yaml.vim'
Plug 'plasticboy/vim-markdown'
Plug 'asciidoc/vim-asciidoc'
Plug 'leafgarland/typescript-vim'
Plug 'lervag/vimtex'

" Colorschemes
Plug 'morhetz/gruvbox'
" Plug 'jnurmine/Zenburn'
" Plug 'easysid/mod8.vim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Reload files that change on disk.
" set autoread
" autocmd FocusGained * checktime

" Behavior.
set clipboard=unnamedplus
set hidden
set hlsearch incsearch
set ignorecase smartcase
set lazyredraw
set nofoldenable
set noswapfile
set viminfo^=%

" Operation.
set completeopt-=preview
set scrolloff=100
set splitbelow
set splitright
set timeoutlen=300
set ttimeoutlen=0
set visualbell
set wildmenu history=250
set wildmode=longest,list

" Formatting.
set autoindent
set backspace=indent,eol,start
set expandtab
set formatoptions+=t  " Hard wrap text using textwidth
set formatoptions-=o  " Don't continue comments when inserting lines set
set nojoinspaces
set ts=2 sw=2 sts=2
set tw=79

" Visual.
set cursorline
set number
set ruler

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keybinds
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Leader key.
map <Space> <Nop>
let mapleader = " "

" Save pressing Shift to enter command mode.
noremap ; :

" Use Q to execute default register.
" nnoremap Q @q

" Remove highlighting on ESC in normal mode.
nnoremap <silent> <C-c> :noh<return><C-c>

" Disable features.
map q: <Nop>
map Q <Nop>
map <F1> <Nop>
map <esc> <Nop>
imap <esc> <Nop>

" Make visual block mode work with Ctrl+C.
inoremap <C-c> <esc>

" Shortcuts.
nnoremap <leader>s :%s//g<left><left>
vnoremap <leader>s :s//g<left><left>
nnoremap <leader>f mzvipgq`z
nnoremap <leader>r :source ~/.config/nvim/init.vim<return>
nnoremap <leader>R :tabedit ~/.config/nvim/init.vim<return>
nnoremap <leader>l :Loremipsum<return>
nnoremap <leader>a mzggVGy`z
nnoremap <leader>q @q
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

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
let g:ycm_filetype_specific_completion_to_disable = {'python': 1}
let g:ycm_semantic_triggers = {'tex': ['\ref{','\cite{']}

" jedi-vim
" let g:jedi#completions_enabled=0

" syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_post_args = '--ignore=F403,E402,E111,E114,E302'

" indentLine
" let g:indentLine_color_term = 244
" let g:indentLine_conceallevel = 1

" ctrlp.vim
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_user_command = {'types': {
    \ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others']
    \ }, 'fallback': 'find %s -type f'}

" plasticboy/vim-markdown
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_math = 1
let g:vim_markdown_conceal = 0

" reedes/vim-pencil
" let g:pencil#textwidth = 79
let g:pencil#cursorwrap = 0

" morhetz/gruvbox
let g:gruvbox_termcolors = 16
let g:gruvbox_underline = 0
let g:gruvbox_undercurl = 0
let g:gruvbox_italic = 1
" let g:gruvbox_contrast_dark = "soft"
" let g:gruvbox_contrast_light = "hard"

" jnurmine/Zenburn
if exists('g:colors_name') && g:colors_name == 'zenburn'
  highlight LineNr ctermbg=NONE
  highlight CursorLineNr ctermbg=NONE
  highlight CursorColumn cterm=None ctermbg=black
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set t_Co=16
set background=light
colorscheme gruvbox

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Scripts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remove trailing whitespace on save.
autocmd BufWritePre * :%s/\s\+$//e

" Return to last edit position when opening files.
function! ResumeCursorPosition()
  if line("'\"") > 0 && line("'\"") <= line("$") |
    exe "normal! g`\"" |
  endif
endfunction
autocmd BufReadPost * call ResumeCursorPosition()

" Highlight long lines.
match Error /\%80v.\+/

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Languages
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.ad set filetype=asciidoc
autocmd BufNewFile,BufRead *.cls set filetype=tex

autocmd FileType json   setlocal conceallevel=0
autocmd FileType tex    setlocal conceallevel=0
autocmd FileType python setlocal conceallevel=0

" let g:tex_conceal = "agms"
let g:tex_conceal = ""

autocmd FileType markdown,asciidoc,tex call pencil#init()

autocmd FileType python setlocal ts=2 sw=2 sts=2
autocmd BufRead,BufEnter */mindpark/*.py setlocal ts=4 sw=4 sts=4
