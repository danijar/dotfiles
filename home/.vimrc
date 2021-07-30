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
Plug 'vim-scripts/loremipsum'
" Plug 'majutsushi/tagbar'
Plug 'preservim/nerdtree'

" Editing.
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'nelstrom/vim-visual-star-search'
Plug 'reedes/vim-pencil'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-commentary'
Plug 'bimlas/vim-numutils'

" Codel intel.
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim'
" Plug 'deoplete-plugins/deoplete-jedi'
" Plug 'davidhalter/jedi-vim'
Plug 'pangloss/vim-javascript'

" Visuals.
Plug 'ap/vim-css-color'
Plug 'plasticboy/vim-markdown'
" Plug 'morhetz/gruvbox'
" Plug 'jnurmine/Zenburn'
" Plug 'easysid/mod8.vim'
Plug 'w0ng/vim-hybrid'

" Polyfills.
" Plug 'amerlyq/vim-focus-autocmd'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'dbakker/vim-paragraph-motion'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" dense-analysis/ale
let g:ale_linters = {'python': ['flake8']}
let b:ale_fixers = []  " ['isort']
let g:ale_python_flake8_options = '
\ --ignore=F403,E402,E111,E114,E302,E306,E125,E731,W504,E305,E221,E129,C741,E704,E701,E702'
let g:ale_use_global_executables = 1  " Avoid slow search for virtual envs.
" let g:ale_lint_on_text_changed = 1
" let g:ale_pattern_options = {
" \ '/google/src/.*': {'ale_enabled': 0},
" \}

" Shougo/deoplete.nvim
let g:python3_host_prog = '/usr/bin/python3'
let g:deoplete#enable_at_startup = 1
inoremap <expr> <c-j> pumvisible() ? "\<C-n>" : "\<c-j>"
inoremap <expr> <c-k> pumvisible() ? "\<C-p>" : "\<c-k>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
call deoplete#custom#option('min_pattern_length', 1)
" call deoplete#custom#option('sources', {'_': 'buffer']})

" deoplete-plugins/deoplete-jedi
let g:deoplete#sources#jedi#python_path = '/usr/bin/python3'
let g:deoplete#sources#jedi#enable_typeinfo = 0  " Faster

" davidhalter/jedi-vim
" let g:jedi#completions_enabled = 0
" let g:jedi#force_py_version = 3
" let g:jedi#use_tabs_not_buffers = 1

" ctrlp.vim
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_user_command = {'types': {
\ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others']
\ }, 'fallback': 'find -L %s -type f'}

" SirVer/ultisnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/snippet']
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

" majutsushi/tagbar
" let g:tagbar_sort = 0
" let g:tagbar_width = 30
" let g:tagbar_show_visibility = 0
" let g:tagbar_autofocus = 1
" let g:tagbar_autoclose = 1
" let g:tagbar_compact = 1
" let g:tagbar_iconchars = [' ', ' ']
" let g:tagbar_map_close = '<leader>t'
" autocmd FileType tagbar autocmd BufCreate <c-y>
" autocmd FileType tagbar autocmd BufDelete <c-e>

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

" Yggdroot/indentLine
let g:indentLine_setConceal = 0

" " Netrw
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 25
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END

" preservim/nerdtree
nnoremap <leader>t :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 40
let g:NERDTreeQuitOnOpen = 1
" nnoremap <leader>t :NERDTreeMirror<CR>:NERDTreeFocus<CR>
" Exit Vim if NERDTree is the only window left.
" autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
" autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror

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
set modeline  " Support in-file Vim settings.
set shortmess=A
set updatetime=200
set laststatus=1
" set noshowmode

if has('mac')
  set clipboard=unnamed
else
  set clipboard=unnamedplus
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
" autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match Error /\s\+$/
autocmd BufRead,BufNewFile * match Error /\s\+$/

" Fix autoread in console Vim.
autocmd FocusGained,BufEnter * checktime
" autocmd FocusGained,BufEnter * mode
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

" Show filenames in tmux window.
autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter *
  \ call system("tmux rename-window '" . expand("%:t") . "'")
autocmd VimLeave * call system("tmux setw automatic-rename")

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

" Handle focus events.
" inoremap <esc>[O <esc>:stopinsert<cr>
" inoremap <esc>[I :mode<cr>

" No shift for command mode.
nnoremap ; :

" Don't convert to lowercase by accident.
vnoremap u <nop>
vnoremap <c-u> u

" Hide highlights.
nnoremap <silent> <c-c> :noh<cr>
" nnoremap <esc>^[ <esc>^[

" Line navigation.
" noremap j gj
" noremap k gk
" noremap gj j
" noremap gk k
" noremap H ^
" noremap L $

" Navigate windows and tabs.
nnoremap <c-t> :call feedkeys(':tabe<space><tab>', 't')<cr>
nnoremap <silent> <c-h> :call LeftWindowOrTab()<cr>
" nnoremap <c-j> <c-w>j
" nnoremap <c-k> <c-w>k
nnoremap <silent> <c-l> :call RightWindowOrTab()<cr>
" Terminal needs to be configured to map Ctrl+Shift+h to Esc,h etc.
nnoremap <esc>h :tabm -1<cr>
nnoremap <esc>l :tabm +1<cr>

" Space as leader key.
map <Space> <nop>
let mapleader = " "

" Leader key shortcuts.
nnoremap <leader>s :%s//g<left><left>
vnoremap <leader>s :s//g<left><left>
nnoremap <leader>f gqap
vnoremap <leader>f gq
nnoremap <leader>c :source ~/.vimrc<cr>:doautoall FileType<cr>
nnoremap <leader>C :tabedit ~/.vimrc<cr>
nnoremap <leader>S :tabedit ~/.vim/snippet/python.snippets<cr>
nnoremap <leader>l :mode<cr>
nnoremap <leader>a mzggVGy`z
nnoremap <leader>q @q
nnoremap <leader>e :ALENext<cr>
nnoremap <leader>E :ALEPrevious<cr>
nnoremap <leader>m :make<cr>
nnoremap <leader>h :cd %:h<cr>
nnoremap <leader>o vipo:sort<cr>
vnoremap <leader>o :sort<cr>
nnoremap <leader>j vipJ^
nnoremap <leader>x mzoimport sys; sys.exit()<esc>`z
nnoremap <leader>p "0p
vnoremap <leader>p "0p
nnoremap <leader>y mzvipy`z
" nnoremap <leader>t :TagbarOpen j<cr>:TagbarFoldLevel 99<cr>
nmap <leader>k mzgcip`z
vmap <leader>k gc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Languages
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! PythonSyntax()
  syntax match MyPythonSelf "\<self\>\.\?"
  syntax match MyPythonLibrary "\<np\.\|\<tf\.\|\<scipy\.\<os\."
  syntax match MyPythonKwarg "\((\| \)\@<=\<[A-Za-z0-9_]\+\>="
  syntax match MyPythonNumber "\<[0-9.]\+\>\.\?"
  hi MyPythonSelf    cterm=none ctermfg=gray ctermbg=none
  hi MyPythonLibrary cterm=none ctermfg=gray ctermbg=none
  hi MyPythonKwarg   cterm=none ctermfg=magenta ctermbg=none
  hi MyPythonNumber  cterm=none ctermfg=red ctermbg=none
endfunction

autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.ad set filetype=asciidoc
autocmd BufNewFile,BufRead *.cls set filetype=tex
autocmd BufNewFile,BufRead *.scss set tw=0

autocmd FileType python setlocal ts=2 sw=2 sts=2
autocmd FileType python setlocal tw=79
autocmd FileType python call PythonSyntax()
" autocmd FileType python,sh setlocal iskeyword-=_
autocmd FileType tex set conceallevel=0

augroup pencil
  autocmd!
  autocmd FileType tex call pencil#init({'wrap': 'soft'})
  " autocmd FileType text,markdown call pencil#init({'wrap': 'hard'})
augroup END
