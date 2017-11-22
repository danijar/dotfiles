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
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-conflicted'
Plug 'vim-scripts/loremipsum'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Editing.
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'nelstrom/vim-visual-star-search'

" Codel intel.
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
Plug 'vim-syntastic/syntastic'
Plug 'pycqa/flake8', {'do': 'pip install --user flake8'}

" Languages
Plug 'plasticboy/vim-markdown'
Plug 'asciidoc/vim-asciidoc'
Plug 'leafgarland/typescript-vim'
Plug 'lervag/vimtex'

" Visuals.
Plug 'morhetz/gruvbox'
Plug 'jnurmine/Zenburn'
Plug 'easysid/mod8.vim'
Plug 'w0ng/vim-hybrid'

" Behavior.
Plug 'amerlyq/vim-focus-autocmd'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

call plug#end()

if ! empty(glob('/usr/share/vim/google/google.vim'))
  source /usr/share/vim/google/google.vim
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Shougo/deoplete.nvim
let g:deoplete#enable_at_startup = 1
inoremap <expr> <c-j> pumvisible() ? "\<C-n>" : "\<c-j>"
inoremap <expr> <c-k> pumvisible() ? "\<C-p>" : "\<c-k>"
let g:deoplete#enable_smart_case = 1
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" zchee/deoplete-jedi
" let g:deoplete#sources#jedi#python_path = '/usr/local/bin/python3.6'

" davidhalter/jedi-vim
let g:jedi#completions_enabled = 0
let g:jedi#force_py_version = 3
let g:jedi#use_tabs_not_buffers = 1

" syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_post_args = '--ignore=F403,E402,E111,E114,E302,E306,E125,E731'

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
set lazyredraw
set clipboard=unnamedplus
set hidden
set hlsearch incsearch
set ignorecase smartcase
set nofoldenable
set viminfo^=%
set completeopt-=preview  " Disable docstring window for completions.
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
set undofile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Directories
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

silent call system('mkdir -p $HOME/.vim/undo')
set undodir=$HOME/.vim/undo//

silent call system('mkdir -p $HOME/.vim/swap')
set directory=$HOME/.vim/swap//

silent call system('mkdir -p $HOME/.vim/backup')
set backupdir=$HOME/.vim/backup//

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color scheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set background=dark
" set background=light
colorscheme hybrid

" w0ng/vim-hybrid
if exists('g:colors_name') && g:colors_name == 'hybrid'
  hi CursorLineNr ctermbg=black
  hi ErrorMsg           cterm=none ctermfg=red   ctermbg=none
  hi SpellBad           cterm=none ctermfg=black ctermbg=red
  hi TabLine            cterm=none ctermfg=gray  ctermbg=black
  hi MatchParen         cterm=none ctermfg=lightgray  ctermbg=lightblue
  hi TabLineFill        cterm=none ctermfg=none  ctermbg=black
  hi TabLineSel         cterm=bold ctermfg=gray  ctermbg=none
  hi DiffAdd            cterm=none ctermfg=none  ctermbg=green
  hi DiffChange         cterm=none ctermfg=none  ctermbg=blue
  hi DiffDelete         cterm=none ctermfg=none  ctermbg=red
  hi SyntasticErrorSign cterm=none ctermfg=red   ctermbg=none
endif

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
autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match Error /\s\+$/

" Fix autoread in console Vim.
autocmd FocusGained,BufEnter * mode
" autocmd FocusLost * call feedkeys("\<C-\>\<C-n>")

" Focus right split or otherwise next tab.
function! RightWindowOrTab()
  let win_no = winnr()
  wincmd l
  if win_no == winnr()
    normal gt
  endif
endfunction

" Focus left split or otherwise previous tab.
function! LeftWindowOrTab()
  let win_no = winnr()
  wincmd h
  if win_no == winnr()
    normal gT
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key bindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable features.
map q: <nop>
map Q <nop>
map <f1> <nop>

" Fix block editing.
inoremap <c-c> <esc>

" Handle focus events.
inoremap <esc>[O <esc>:stopinsert<cr>
inoremap <esc>[I :mode<cr>

" No shift for command mode.
noremap ; :

" Don't convert to lowercase by accident.
vnoremap u <nop>
vnoremap <c-u> u

" Hide highlights.
nnoremap <silent> <c-c> :noh<cr>
nnoremap <esc>^[ <esc>^[

" Line navigation.
noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap k gk
noremap H ^
noremap L $

" Navigate windows and tabs.
nnoremap <c-t> :call feedkeys(':tabe<space><tab>', 't')<cr>
nnoremap <silent> <c-h> :call LeftWindowOrTab()<cr>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <silent> <c-l> :call RightWindowOrTab()<cr>
nnoremap <esc>h :tabm -1<cr>
nnoremap <esc>l :tabm +1<cr>

" Space as leader key.
map <Space> <nop>
let mapleader = " "

" File search using fzf.
" nnoremap <c-p> :Files<cr>

" Leader key shortcuts.
nnoremap <leader>s :%s//g<left><left>
vnoremap <leader>s :s//g<left><left>
nnoremap <leader>f gqap
vnoremap <leader>f gq
nnoremap <leader>c :source ~/.vimrc<cr>
nnoremap <leader>C :tabedit ~/.vimrc<cr>
nnoremap <leader>l :Loremipsum<cr>
nnoremap <leader>a mzggVGy`z
nnoremap <leader>q @q
nnoremap <leader>e :Errors<cr>:lclose<cr>:lnext<cr>
nnoremap <leader>E :Errors<cr>:lclose<cr>:lprev<cr>
nnoremap <leader>m :make<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Languages
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.ad set filetype=asciidoc
autocmd BufNewFile,BufRead *.cls set filetype=tex

autocmd FileType json   setlocal conceallevel=0
autocmd FileType tex    setlocal conceallevel=0
autocmd FileType python setlocal conceallevel=0
autocmd FileType python setlocal ts=2 sw=2 sts=2
