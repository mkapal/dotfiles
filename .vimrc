set termguicolors
set hidden
set number
set relativenumber
set expandtab
set smarttab
set tabstop=2
set shiftwidth=2
set updatetime=100
set noshowmode
set noruler
set laststatus=0

let g:nerdtree_tabs_open_on_console_startup=1
let g:nerdtree_tabs_autofind=1
let NERDTreeShowHidden=1

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

call plug#begin('~/.vim/plugged')

Plug 'blueshirts/darcula'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'pangloss/vim-javascript'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'ervandew/supertab'
Plug 'tpope/vim-commentary'
Plug 'w0rp/ale'
Plug 'tpope/vim-surround'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'

call plug#end()

colorscheme darcula
syntax on

let g:ale_fixers = {'javascript': ['prettier']}
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_linters_explicit = 1
let g:SuperTabDefaultCompletionType = "context"

highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen

" Show trailing whitepace and spaces before a tab:
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

filetype plugin on
au FileType php setl ofu=phpcomplete#CompletePHP
au FileType ruby,eruby setl ofu=rubycomplete#Complete
au FileType html,xhtml setl ofu=htmlcomplete#CompleteTags
au FileType c setl ofu=ccomplete#CompleteCpp
au FileType css setl ofu=csscomplete#CompleteCSS

map <C-n> :NERDTreeToggle<CR>
map <C-l> :bn<CR>
map <C-h> :bp<CR>
map <C-p> :FZF<CR>
