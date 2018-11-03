" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
let mapleader=","

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

Plug 'itchyny/lightline.vim'

  set laststatus=2

  let g:lightline = {
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'fugitive', 'gitgutter', 'readonly', 'filename' ] ],
        \ },
        \ 'component_function': {
        \   'filename': 'LightlineFilename',
        \   'fugitive': 'LightLineFugitive',
        \   'gitgutter': 'LightLineGitGutter'
        \ }
      \ }

  function! LightlineFilename()
    let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    let modified = &modified ? ' +' : ''
    return filename . modified
  endfunction

  function! LightLineFugitive()
    return exists('*fugitive#head') ? fugitive#head() : ''
  endfunction

  function! LightLineGitGutter()
    if ! exists('*GitGutterGetHunkSummary')
          \ || ! get(g:, 'gitgutter_enabled', 0)
          \ || winwidth('.') <= 90
      return ''
    endif
    let symbols = [
          \ g:gitgutter_sign_added,
          \ g:gitgutter_sign_modified,
          \ g:gitgutter_sign_removed
          \ ]
    let hunks = GitGutterGetHunkSummary()
    let ret = []
    for i in [0, 1, 2]
      if hunks[i] > 0
        call add(ret, symbols[i] . hunks[i])
      endif
    endfor
    return join(ret, ' ')
  endfunction

Plug 'nathanaelkane/vim-indent-guides'

  let g:indent_guides_default_mapping = 0
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_start_level = 2
  let g:indent_guides_guide_size = 1
  let g:indent_guides_exclude_filetypes = ['help', 'startify', 'man', 'rogue']
  let g:indent_guides_auto_colors = 0

  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#2D2D2D
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#2D2D2D

  " File navigation =============================================================

Plug 'scrooloose/nerdtree'

  let NERDTreeShowHidden=1       " Show hidden files
  let NERDTreeMinimalUI=1        " Do not show help text at the top
  let NERDTreeDirArrows=1
  let NERDTreeAutoDeleteBuffer=1 " Automatically delete file buffer after deleting it in NERDTree

  " NERDTree toggle
  nnoremap <silent> <Leader>, :call NERDTreeToggleAndFind()<CR>

  function! NERDTreeToggleAndFind()
    if (exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1)
      execute ':NERDTreeClose'
    else
      execute ':NERDTreeFind'
    endif
  endfunction

  " Automatically close NERDTree when it's the last window open
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

  " Fuzzy search all files including hidden and ignore files
  command! -bang -nargs=? -complete=dir HFiles
  \ call fzf#vim#files(<q-args>, {'source': $FZF_DEFAULT_COMMAND}, <bang>0)

  nnoremap <silent> <C-f> :HFiles<CR>

" Text manipulation ===========================================================

Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'

" Git integration =============================================================

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

  nnoremap <silent> <leader>d :Gvdiff<CR>

" Languages ===================================================================

Plug 'othree/yajs.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'mxw/vim-jsx'
Plug 'HerringtonDarkholme/yats.vim'

  let g:used_javascript_libs='react'

Plug 'Valloric/YouCompleteMe', { 'do': 'python2 install.py --tern-completer' }

  " Go to definition of the symbol under cursor
  nnoremap <leader>jd :YcmCompleter GoTo<CR>

  " Rename symbol under cursor
  nnoremap <expr> <leader>rr ':YcmCompleter RefactorRename ' . expand('<cword>')

  let g:ycm_key_invoke_completion = '<C-Space>'
  let g:ycm_autoclose_preview_window_after_insertion = 1

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
