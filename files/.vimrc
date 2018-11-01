set termguicolors
set nocompatible
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
set timeoutlen=1000 ttimeoutlen=0
set showcmd
set path+=**
set wildmenu

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'blueshirts/darcula'
"Plug 'scrooloose/nerdtree'
"Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

let g:airline_theme='murmur'

colorscheme darcula
syntax enable
filetype plugin on

" NERDTree
"let g:nerdtree_tabs_open_on_console_startup=1
"let g:nerdtree_tabs_autofind=1
"let NERDTreeShowHidden=1

highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen

" Show trailing whitepace and spaces before a tab:
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

