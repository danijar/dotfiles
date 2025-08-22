set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! SetupDeoplete()
  call system('pip3 install -U neovim pynvim')
  UpdateRemotePlugins
endfunction

call plug#begin('~/.vim/plugged')

" Tools
Plug 'junegunn/fzf'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-eunuch'
Plug 'vim-scripts/loremipsum'

" Editing
Plug 'nelstrom/vim-visual-star-search'
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'hrsh7th/vim-vsnip'
Plug 'tomtom/tcomment_vim'

" Codel intel
Plug 'dense-analysis/ale', { 'do': 'pip3 install ruff' }
Plug 'Shougo/deoplete.nvim', { 'do': { -> SetupDeoplete() } }
Plug 'deoplete-plugins/deoplete-jedi', { 'do': 'pip3 install jedi' }

" Syntax highlighting
Plug 'pangloss/vim-javascript'
Plug 'DingDean/wgsl.vim'
Plug 'plasticboy/vim-markdown'
Plug 'posva/vim-vue'

" Visuals
" Plug 'itchyny/vim-cursorword'
Plug 'ap/vim-css-color'
Plug 'w0ng/vim-hybrid'
Plug 'morhetz/gruvbox'
" Plug 'wellle/context.vim'
Plug 'luochen1990/rainbow'

" Polyfills
Plug 'dbakker/vim-paragraph-motion'
if !has('nvim')
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()

" autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
"   \| PlugInstall --sync | source $MYVIMRC
" \| endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" junegunn/fzf
let fzfcmd = "rg --files --hidden --no-ignore -g '!{.git,node_modules,__pycache__}'"
nnoremap <silent> <C-P> :call fzf#run(fzf#wrap({ 'source': fzfcmd }))<cr>
let g:fzf_history_dir = '/tmp/fzf_history'
let g:fzf_layout = {'window': 'new', 'down': '40%'}
let g:fzf_action = {
  \ 'return': 'drop',
  \ 'ctrl-t': 'tab drop',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" airblade/vim-gitgutter
let g:gitgutter_set_sign_backgrounds = 1

" ctrlp.vim
" let g:ctrlp_working_path_mode = 'a'
" let g:ctrlp_user_command = {'types': {
" \ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others']
" \ }, 'fallback': 'find -L %s -type f'}

" dense-analysis/ale
let g:ale_linters = {'python': ['ruff'], 'javascript': [], 'vue': []}
let b:ale_fixers = []
let g:ale_python_ruff_options = '--preview --line-length 79 --select E4,E5,E7,E9,F,PERF,PIE --ignore E111,E114,E731,E402,E701,E702,F722,FBT,PERF102,PERF203,PERF401,E721,PERF403'
let g:ale_virtualtext_cursor = 0
" Avoid slow search for virtual envs.
let g:ale_use_global_executables = 1
let g:ale_virtualenv_dir_names=[]
" Disable automatic linting.
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_virtualtext_cursor = 'disabled'

" Shougo/deoplete.nvim
let g:deoplete#enable_at_startup = 1
inoremap <expr> <c-j> pumvisible() ? "\<C-n>" : "\<c-j>"
inoremap <expr> <c-k> pumvisible() ? "\<C-p>" : "\<c-k>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
call deoplete#custom#option('min_pattern_length', 1)
" call deoplete#custom#option('sources', {'_': 'buffer']})
call deoplete#custom#option('auto_complete_delay', 100)

" deoplete-plugins/deoplete-jedi
" let g:deoplete#sources#jedi#python_path = '/usr/bin/python3'
let g:deoplete#sources#jedi#enable_typeinfo = 0  " Faster

" davidhalter/jedi-vim
" let g:jedi#completions_enabled = 0
let g:jedi#completions_enabled = 1
let g:jedi#force_py_version = 3
let g:jedi#use_tabs_not_buffers = 1

" hrsh7th/vim-vsnip
imap <expr> <Tab> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<Tab>'

" plasticboy/vim-markdown
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_math = 1
let g:vim_markdown_conceal = 0

" w0ng/vim-hybrid
let g:hybrid_custom_term_colors = 1

" morhetz/gruvbox
let g:gruvbox_termcolors=16

" Yggdroot/indentLine
let g:indentLine_setConceal = 0

" itchyny/vim-cursorword
let g:cursorword_highlight=0

" wellle/context.vim
let g:context_enabled = 1
let g:context_max_height = 1

" luochen1990/rainbow
let g:rainbow_active = 0
let g:rainbow_conf = {
\	'ctermfgs': ['white', 'lightgray', 'lightyellow', 'lightcyan', 'lightmagenta'],
\	'operators': '',
\	'parentheses': ['start=/(/ end=/)/ fold'],
\ }
" \	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set encoding=utf-8
set lazyredraw
set ttyfast
set hidden
set hlsearch incsearch
set ignorecase smartcase
set nofoldenable
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
set formatoptions-=t
set formatoptions-=o
set nojoinspaces
set ts=2 sw=2 sts=2
set cursorline
set number
set ruler
set mouse=a
set autoread
set undofile
set modeline
set shortmess=lxWAIF
set updatetime=200
set laststatus=1
set breakindent
let g:python3_host_prog = 'python3'

if has('mac')
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif

if has('nvim')
  let &inccommand = ""
  " set display-=msgsep
  set display=lastline
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status Line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Only visible with multiple splits or lasstatus=2.
set statusline=
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
set statusline+=%#DiffChange#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=%#Cursor#                 " Color
set statusline+=\ %n\                     " Buffer number
set statusline+=%#Visual#                 " Color
set statusline+=%{&paste?'\ PASTE\ ':''}  " Paste mode
set statusline+=%{&spell?'\ SPELL\ ':''}  " Spell mode
set statusline+=%#CursorIM#               " Color
set statusline+=%R                        " Readonly flag
set statusline+=%M                        " Modified flag
set statusline+=%#Cursor#                 " Color
set statusline+=%#CursorLine#             " Color
set statusline+=\ %t\                     " Short file name
set statusline+=%=                        " Right align
set statusline+=%#CursorLine#             " Color
set statusline+=\ %Y\                     " File type
set statusline+=%#CursorIM#               " Color
set statusline+=\ %3l:%-2c\               " Line + column
set statusline+=%#Cursor#                 " Color
set statusline+=\ %3p%%\                  " Percentage

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

set notermguicolors
set background=dark
" set background=light
colorscheme hybrid
" colorscheme gruvbox

hi Normal              ctermfg=white      ctermbg=none
hi LineNr              ctermfg=darkgray   ctermbg=none
hi Visual                                 ctermbg=darkgray
hi CursorLineNr        ctermfg=gray       ctermbg=black
hi SignColumn                             ctermbg=none
hi MatchParen          ctermfg=black      ctermbg=lightblue
hi TabLine             ctermfg=gray       ctermbg=black    cterm=none
hi TabLineFill                            ctermbg=black     cterm=none
hi TabLineSel          ctermfg=black      ctermbg=gray

hi ErrorMsg            ctermfg=red        ctermbg=none
hi SpellBad            ctermfg=black      ctermbg=red
hi DiffAdd             ctermfg=none       ctermbg=green
hi DiffChange          ctermfg=none       ctermbg=blue
hi DiffDelete          ctermfg=none       ctermbg=red
hi SyntasticErrorSign  ctermfg=red        ctermbg=none
hi GitGutterAdd        ctermbg=none
hi GitGutterChange     ctermbg=none
hi GitGutterDelete     ctermbg=none

" hi CursorWord0        cterm=bold               ctermbg=black
" hi CursorWord1                                 ctermbg=black

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Scripts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remove trailing whitespace on save for most file types.
let allowTrailingSpaces = ['snippets']
autocmd BufWritePre * if index(allowTrailingSpaces, &ft) < 0 | %s/\s\+$//e

" Return to last edit position when opening files.
function! ResumeCursorPosition()
  if line("'\"") > 0 && line("'\"") <= line("$") |
    exe "normal! g`\"" |
  endif
endfunction
autocmd BufReadPost * call ResumeCursorPosition()

" Write file with sudo permissions.
cmap w!! w !sudo tee % >/dev/null

" Highlight trailing whitespace.
autocmd BufRead,BufNewFile * match Error /\s\+$/

" Fix autoread in console Vim.
autocmd FocusGained,BufEnter * checktime

" Show filenames in tmux window.
autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter *
  \ call system("tmux rename-window '" . expand("%:t") . "'")
autocmd VimLeave * call system("tmux setw automatic-rename")

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Focus Movements
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! SplitTabPaneRight()
  let win = winnr()
  wincmd l
  if win != winnr()
    return
  elseif tabpagenr() != tabpagenr('$')
    normal gt
  else
    :call system('tmux select-pane -R')
  endif
endfunction

function! SplitTabPaneLeft()
  let win = winnr()
  wincmd h
  if win != winnr()
    return
  elseif tabpagenr() != 1
    normal gT
  else
    :call system('tmux select-pane -L')
  endif
endfunction

function! SplitTabDown()
  let win = winnr()
  wincmd j
  if win == winnr()
    :call system('tmux select-pane -D')
  endif
endfunction

function! SplitPaneUp()
  let win = winnr()
  wincmd k
  if win == winnr()
    :call system('tmux select-pane -U')
  endif
endfunction

nnoremap <silent> <c-h> :call SplitTabPaneLeft()<cr>
nnoremap <silent> <c-l> :call SplitTabPaneRight()<cr>
nnoremap <silent> <c-j> :call SplitTabDown()<cr>
nnoremap <silent> <c-k> :call SplitPaneUp()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key bindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable features.
map q: <nop>
map Q <nop>
map <f1> <nop>

" Leaving insert mode.
inoremap <c-c> <esc>
inoremap <c-v> <esc>
vnoremap <c-c> <esc>
vnoremap <c-v> <esc>

" No shift for command mode.
nnoremap ; :

" Don't convert to lowercase by accident.
vnoremap u <nop>
vnoremap <c-u> u

" Hide highlights.
nnoremap <silent> <c-c> :noh<cr>
" nnoremap <esc>^[ <esc>^[

" Open file in new tab.
nnoremap <c-t> :call feedkeys(':tabe<space><tab>', 't')<cr>

" Move tabs.
" Terminal needs to be configured to map Ctrl+Shift+h to Esc,h etc.
nnoremap <esc>h :tabm -1<cr>
nnoremap <esc>l :tabm +1<cr>

" Tmux clipboard integration.
vnoremap ty y:call system("tmux load-buffer -", @0)<cr>
nnoremap tp :let @0 = system("tmux save-buffer -")<cr>"0p
nnoremap tP :let @0 = system("tmux save-buffer -")<cr>"0P
vnoremap tp :let @0 = system("tmux save-buffer -")<cr>"0p
vnoremap tP :let @0 = system("tmux save-buffer -")<cr>"0P

" Space as leader key.
map <Space> <nop>
let mapleader = " "

" Leader key shortcuts.
nnoremap <leader>s :%s//g<left><left>
" vnoremap <leader>s :s/\%V/g<left><left>
vnoremap <leader>s :s//g<left><left>

nnoremap <leader>f gqap
vnoremap <leader>f gq
nnoremap <leader>c :source ~/.vimrc<cr>:doautoall FileType<cr>
nnoremap <leader>C :tab drop ~/.vimrc<cr>
nnoremap <leader>S :tab drop ~/.vim/snippet/python.snippets<cr>
nnoremap <leader>l :mode<cr>
nnoremap <leader>a mzggVGy`z
nnoremap <leader>q @q
nnoremap <leader>l :ALELint<cr>
nnoremap <leader>e :ALENext<cr>
nnoremap <leader>E :ALEPrevious<cr>
nnoremap <leader>m :make<cr>
nnoremap <leader>h :cd %:h<cr>:pwd<cr>
nnoremap <leader>o vipo:sort<cr>
vnoremap <leader>o :sort<cr>
nnoremap <leader>j vipJ^
nnoremap <leader>x mzoimport sys; sys.exit()<esc>`z
nnoremap <leader>i mzoimport ipdb; ipdb.set_trace()<esc>`z
nnoremap <leader>t mzA  # TODO<esc>`z
nnoremap <leader>p "0p
vnoremap <leader>p "0p
nnoremap <leader>y mzvipy`z
nnoremap <leader>b :0,$!yapf<cr>
nmap <leader>k mzgcip`z
vmap <leader>k gc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Languages
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! PythonSyntax()
  syntax keyword MyPythonConstants True False None Ellipsis
  syntax match MyPythonSelf "\<self\>\.\?"
  syntax match MyPythonLibrary "\<np\.\|\<tf\.\|\<scipy\.\<os\."
  syntax match MyPythonKwarg "\((\| \)\@<=\<[A-Za-z0-9_]\+\>="
  syntax match MyPythonNumber "\<[0-9.]\+\>\.\?"
  syntax match MyPythonFunction /\v[[:alpha:]_.]+\ze\s?\(/
  syntax match MyPythonUnpack '\*\*\?\ze[a-z]'
  syntax match MyPythonContainers /[][}{]/
  " syntax match MyPythonParens /[()]/
  hi MyPythonSelf       cterm=none ctermfg=gray ctermbg=none
  hi MyPythonLibrary    cterm=none ctermfg=gray ctermbg=none
  hi MyPythonKwarg      cterm=none ctermfg=magenta ctermbg=none
  hi MyPythonNumber     cterm=none ctermfg=red ctermbg=none
  hi MyPythonUnpack     cterm=none ctermfg=lightgray ctermbg=none
  " hi MyPythonContainers cterm=none ctermfg=darkgray ctermbg=lightgray
  hi def link MyPythonFunction Function
  hi def link MyPythonConstants Constant
endfunction

autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.ad set filetype=asciidoc
autocmd BufNewFile,BufRead *.cls set filetype=tex
autocmd BufNewFile,BufRead *.scss set tw=0
autocmd BufNewFile,BufRead *Dockerfile* set filetype=dockerfile
autocmd BufNewFile,BufRead * set conceallevel=0

autocmd FileType python setlocal ts=2 sw=2 sts=2 tw=79
autocmd FileType python call PythonSyntax()
autocmd FileType markdown,tex set conceallevel=0
