set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Tools.
Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-eunuch'

" Editing.
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'nelstrom/vim-visual-star-search'

" Codel intel.
Plug 'Valloric/YouCompleteMe', {'do': './install.py'}
Plug 'bjoernd/vim-ycm-tex'
" Plug 'davidhalter/jedi-vim'
Plug 'vim-syntastic/syntastic'
Plug 'pycqa/flake8', {'do': 'pip install --user flake8'}

" Languages
Plug 'yaml.vim'
Plug 'plasticboy/vim-markdown'
Plug 'asciidoc/vim-asciidoc'
Plug 'leafgarland/typescript-vim'
Plug 'lervag/vimtex'

" Visuals.
Plug 'morhetz/gruvbox'
Plug 'jnurmine/Zenburn'
Plug 'easysid/mod8.vim'
Plug 'w0ng/vim-hybrid'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_post_args = '--ignore=F403,E402,E111,E114,E302,E306,E125'

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
let g:gruvbox_termcolors = 16
let g:gruvbox_underline = 0
let g:gruvbox_undercurl = 0
let g:gruvbox_italic = 1

" w0ng/vim-hybrid
let g:hybrid_custom_term_colors = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set encoding=utf-8
set clipboard=unnamedplus
set hidden
set hlsearch incsearch
set ignorecase smartcase
set nofoldenable
set noswapfile
set viminfo^=%
set completeopt-=preview
set scrolloff=100
set splitbelow
set splitright
set timeoutlen=300
set ttimeoutlen=0
set visualbell
set wildmenu history=250
set wildmode=longest,list
set autoindent
set backspace=indent,eol,start
set expandtab
set formatoptions+=t
set formatoptions-=o
set nojoinspaces
set ts=2 sw=2 sts=2
set tw=79
set cursorline
set number
set ruler
set mouse=a
set autoread

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color scheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set t_Co=256
set background=dark
colorscheme hybrid

" w0ng/vim-hybrid
if exists('g:colors_name') && g:colors_name == 'hybrid'
  highlight CursorLineNr ctermbg=black
  highlight ErrorMsg ctermfg=red
  highlight SpellBad cterm=none ctermbg=red ctermfg=black
  highlight SyntasticErrorSign ctermbg=none ctermfg=red
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key bindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable features.
map q: <Nop>
map Q <Nop>
map <F1> <Nop>
map <esc> <Nop>
imap <esc> <Nop>

" Fix block editing.
inoremap <C-c> <esc>

" No shift for command mode.
noremap ; :

" Hide highlights.
nnoremap <silent> <C-c> :noh<return><C-c>
nnoremap <esc>^[ <esc>^[

" Don't convert to lowercase by accident.
vnoremap u <Nop>
vnoremap <C-u> u

" Line navigation.
noremap H ^
noremap L $

" Tab navigation.
nnoremap <silent> <C-t> :tabe<return>
" nnoremap <C-H> :tabm -1<return>
" nnoremap <C-L> :tabm +1<return>

" Window navigation.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Space as leader key.
map <Space> <Nop>
let mapleader = " "

" Leader key shortcuts.
nnoremap <leader>s :%s//g<left><left>
vnoremap <leader>s :s//g<left><left>
" vnoremap <leader>f mzvipgq`z
nnoremap <leader>f gqap
vnoremap <leader>f gq
nnoremap <leader>r :source ~/.vimrc<return>
nnoremap <leader>R :tabedit ~/.vimrc<return>
nnoremap <leader>l :Loremipsum<return>
nnoremap <leader>a mzggVGy`z
nnoremap <leader>q @q
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<return>
nnoremap <leader>e :Errors<return><C-w>j

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

" Write file with sudo permissions.
cmap w!! w !sudo tee % >/dev/null

" Highlight long lines.
" match Error /\%80v.\+/

" Highlight trailing whitespace.
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match Error /\s\+$/

" Fix autoread in console Vim.
" au FocusGained * :echotime

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Languages
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.ad set filetype=asciidoc
autocmd BufNewFile,BufRead *.cls set filetype=tex

autocmd FileType json   setlocal conceallevel=0
autocmd FileType tex    setlocal conceallevel=0
autocmd FileType python setlocal conceallevel=0

let g:tex_conceal = ""

autocmd FileType markdown,asciidoc call pencil#init()

autocmd FileType python setlocal ts=2 sw=2 sts=2
autocmd BufRead,BufEnter */mindpark/*.py setlocal ts=4 sw=4 sts=4
