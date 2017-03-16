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
Plug 'scrooloose/syntastic'

" Languages
Plug 'yaml.vim'
Plug 'plasticboy/vim-markdown'
Plug 'asciidoc/vim-asciidoc'
Plug 'leafgarland/typescript-vim'
Plug 'lervag/vimtex'

" Visuals.
Plug 'morhetz/gruvbox'
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
let g:syntastic_python_flake8_post_args = '--ignore=F403,E402,E111,E114,E302'

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color scheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set t_Co=256
set background=dark
colorscheme hybrid

" w0ng/vim-hybrid
if exists('g:colors_name') && g:colors_name == 'hybrid'
  highlight CursorLineNr ctermbg=black
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

" Space as leader key.
map <Space> <Nop>
let mapleader = " "

" Open new tab.
nnoremap <C-t> :tabe<return>

" Leader key shortcuts.
nnoremap <leader>s :%s//g<left><left>
vnoremap <leader>s :s//g<left><left>
nnoremap <leader>f mzvipgq`z
nnoremap <leader>r :source ~/.vimrc<return>
nnoremap <leader>R :tabedit ~/.vimrc<return>
nnoremap <leader>l :Loremipsum<return>
nnoremap <leader>a mzggVGy`z
nnoremap <leader>q @q
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<return>

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
" match Error /\%80v.\+/

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
