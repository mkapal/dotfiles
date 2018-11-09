" If vim-plug is not installed, download it and install all plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" General {{{
set nocompatible
set hidden
set updatetime=100
set timeoutlen=1000 ttimeoutlen=0 " Eliminate delays after exiting normal mode
set history=1000
set lazyredraw
set scrolloff=3

" Map escape sequences to Alt combinations
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

let mapleader=";"
map <Leader>vr :so ~/.vimrc<CR>
" }}}
" Colors {{{
Plug 'morhetz/gruvbox'
set background=dark
syntax enable
if (has("termguicolors"))
set termguicolors
endif
Plug 'itchyny/lightline.vim'
" {{{
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
" }}}
Plug 'nathanaelkane/vim-indent-guides'
" {{{
  let g:indent_guides_default_mapping = 0
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_start_level = 2
  let g:indent_guides_guide_size = 1
  let g:indent_guides_exclude_filetypes = ['help', 'startify', 'man', 'rogue']
  let g:indent_guides_auto_colors = 0

  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#2D2D2D
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#2D2D2D
" }}}
" }}}
" Layout {{{
set number
set relativenumber
set showcmd          " Show commands at the bottom as you type them
set noshowmode
set noruler
set cursorline       " highlight current line

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·
" }}}
" Indentation {{{
set expandtab
set smarttab
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
filetype plugin on
filetype indent on
" }}}
" File Navigation {{{
set splitbelow
set splitright

" Creating splits
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" Navigation between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

nnoremap gf :vertical wincmd f<CR>        " Open file under cursor in a new vertical split

" Buffers
" nnoremap <silent>   <C-e> :Buffers<CR>
nnoremap <silent> <S-Tab> :bprevious<CR>
nnoremap <silent>   <Tab> :bnext<CR>

Plug 'scrooloose/nerdtree'
" {{{
  let NERDTreeShowHidden=1            " Show hidden files
  let NERDTreeMinimalUI=1             " Do not show help text at the top
  let NERDTreeDirArrows=1
  let NERDTreeAutoDeleteBuffer=1      " Automatically delete file buffer after deleting it in NERDTree
  let NERDTreeIgnore = ['\.swp$']     " Ignore vim swap files

  " NERDTree toggle
  nnoremap <silent> <leader><leader> :call NERDTreeToggleAndFind()<CR>

  function! NERDTreeToggleAndFind()
    if (exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1)
      execute ':NERDTreeClose'
    else
     if @% == ""
        execute ':NERDTreeToggle'
      else
        execute ':NERDTreeFind'
      endif
    endif
  endfunction

  " Automatically close NERDTree when it's the last window open
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}
Plug 'kien/ctrlp.vim'
" {{{
  nnoremap <silent> <leader>e :CtrlPMRU<CR>
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
" }}}
Plug 'christoomey/vim-tmux-navigator'
" }}}
" Search {{{
set path+=**     " Allow searching in all subdirectories of the current tree
set ignorecase   " Ignore case when searching...
set smartcase    " ...unless we type a capital
Plug 'mileszs/ack.vim'
" {{{
  if executable('ag')
    let g:ackprg = 'ag --vimgrep'
  endif
" }}}
" }}}
" Folding {{{
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
set foldlevelstart=10   " start with fold level of 1
nnoremap <space> za
" }}}
" Text manipulation {{{
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
" {{{
" Move selection up/down
  nnoremap <A-j> :m .+1<CR>==
  nnoremap <A-k> :m .-2<CR>==
  inoremap <A-j> <Esc>:m .+1<CR>==gi
  inoremap <A-k> <Esc>:m .-2<CR>==gi
  vnoremap <A-j> :m '>+1<CR>gv=gv
  vnoremap <A-k> :m '<-2<CR>gv=gv
" }}}
" }}}
" Git integration {{{
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" {{{
  nnoremap <silent> <leader>d :Gvdiff<CR>
" }}}
" }}}
" Languages {{{
Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
" {{{
  " let g:used_javascript_libs='react'
" }}}
" Plug 'Valloric/YouCompleteMe', { 'do': 'python2 install.py --tern-completer' }
" {{{
"  if !exists('g:ycm_semantic_triggers')
"    let g:ycm_semantic_triggers = {}
"  endif
"   let g:ycm_semantic_triggers['typescript'] = ['.']
"   let g:ycm_semantic_triggers['typescript.tsx'] = ['.']

"   " Go to definition of the symbol under cursor
"   nnoremap <leader>jd :YcmCompleter GoTo<CR>

"   " Rename symbol under cursor
"   nnoremap <expr> <leader>rr ':YcmCompleter RefactorRename ' . expand('<cword>')

"   let g:ycm_key_invoke_completion = '<C-@>'
"   let g:ycm_autoclose_preview_window_after_insertion = 1
" " }}}
Plug 'w0rp/ale'
" {{{
  let g:ale_fixers = {
  \   'javascript': ['prettier'],
  \}
  let g:ale_fix_on_save = 1
" }}}
" }}}

call plug#end()

colorscheme gruvbox

" vim:foldmethod=marker:foldlevel=0
