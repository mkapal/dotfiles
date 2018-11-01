" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
let mapleader = ","

" If vim-plug is not installed,
" download it automatically and install all plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Appearance ==================================================================

Plug 'morhetz/gruvbox'

  set background=dark

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

  let g:airline_theme='murmur'

Plug 'nathanaelkane/vim-indent-guides'

" File navigation =============================================================

Plug 'scrooloose/nerdtree'

  let NERDTreeShowHidden = 1       " Show hidden files
  let NERDTreeMinimalUI = 1        " Do not show help text at the top
  let NERDTreeDirArrows = 1
  let NERDTreeAutoDeleteBuffer = 1 " Automatically delete file buffer after deleting it in NERDTree

  " NERDTree toggle
  nnoremap <silent> <Leader>, :NERDTreeToggle<CR>

  " Automatically close NERDTree when it's the last window open
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'

  " Fuzzy search all files including hidden and ignore files
  command! -bang -nargs=? -complete=dir HFiles
  \ call fzf#vim#files(<q-args>, {'source': 'ag --hidden --ignore .git -g ""'}, <bang>0)

  nnoremap <silent> <C-f> :HFiles<CR>

" Text manipulation ===========================================================

Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'

" Git integration =============================================================

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Languages ===================================================================

Plug 'othree/yajs.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'mxw/vim-jsx'
Plug 'HerringtonDarkholme/yats.vim'

  let g:used_javascript_libs = 'react'

" Utility =====================================================================

Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" General settings ============================================================

set hidden
set number
set relativenumber
set updatetime=100
set timeoutlen=1000 ttimeoutlen=0 " Eliminate delays after exiting normal mode
set showcmd                       " Show commands at the bottom as you type them
set history=1000

" Current mode and ruler is taken care of by vim-airline
set noshowmode
set noruler

" Splits
set splitbelow
set splitright

" Search
set path+=**     " Allow searching in all subdirectories of the current tree
set ignorecase   " Ignore case when searching...
set smartcase    " ...unless we type a capital

" Source current file Alt-% (good for vim development)
map <Leader>vr :so ~/.vimrc<CR>

" Switching between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Create window splits
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" TODO Move current line up/down

" Open file under cursor in a new vertical split
nnoremap gf :vertical wincmd f<CR>

" Navigating between buffers
noremap <silent> <C-e> :Buffers<CR>

set wildmenu

" Things to ignore when tab autocompleting
set wildignore=node_modules/**

" Indentation
set expandtab
set smarttab
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" Colors
 syntax enable
 if (has("termguicolors"))
  set termguicolors
 endif

colorscheme gruvbox

set cursorline     " highlight current line
