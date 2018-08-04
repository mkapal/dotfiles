set termguicolors
colorscheme darcula
syntax on
set number
set relativenumber
set expandtab
set smarttab
set tabstop=2
set shiftwidth=2

let g:nerdtree_tabs_open_on_console_startup=1
let g:nerdtree_tabs_autofind=1

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'jistr/vim-nerdtree-tabs'

call plug#end()

highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen

" Show trailing whitepace and spaces before a tab:
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

map <C-n> :NERDTreeTabsToggle<CR>
map <C-l> :tabn<CR>
map <C-h> :tabp<CR>
