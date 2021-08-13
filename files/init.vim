" If vim-plug is not installed, download it and install all plugins
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" General {{{
set hidden
set updatetime=100
set timeoutlen=1000 ttimeoutlen=0 " Eliminate delays after exiting normal mode
set history=1000
set lazyredraw
set scrolloff=3

let mapleader=";"
map <Leader>vr :so ~/.config/nvim/init.vim<CR>

" Check file changes on focus
Plug 'djoshea/vim-autoread'
" }}}
" Colors {{{
Plug 'morhetz/gruvbox'
Plug 'doums/darcula'
set background=dark
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
" }}}
" Layout {{{
set number
set relativenumber
set noshowmode
set noruler
set cursorline       " highlight current line

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·
" }}}
" Indentation {{{
set expandtab
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
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

nnoremap gf :vertical wincmd f<CR>  " Open file under cursor in a new vertical split

" Buffers
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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" {{{
  " Fuzzy search all files including hidden and ignore files
  command! -bang -nargs=? -complete=dir HFiles
  \ call fzf#vim#files(<q-args>, {'source': $FZF_DEFAULT_COMMAND}, <bang>0)

  " TODO
  " Default options are --nogroup --column --color
  " let s:ag_options = ' --one-device --skip-vcs-ignores --smart-case '
  " command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--hidden --ignore .git -l', <bang>0)

  nnoremap <silent> <C-p> :GFiles<CR>
  nnoremap <silent> <C-e> :Buffers<CR>
  nnoremap <silent> <C-f> :Ag<CR>
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
set foldmethod=marker   " fold based on markers
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
  nnoremap <leader>j :m .+1<CR>==
  nnoremap <leader>k :m .-2<CR>==
  vnoremap <leader>j :m '>+1<CR>gv=gv
  vnoremap <leader>k :m '<-2<CR>gv=gv
" }}}
" }}}
" Git integration {{{
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" {{{
  nnoremap <silent> <leader>d :Gvdiff<CR>
" }}}
Plug 'idanarye/vim-merginal'
" {{{
  let g:merginal_windowWidth = 80
  nnoremap <silent> <leader>b :Merginal<CR>
" }}}
Plug 'Xuyuanp/nerdtree-git-plugin'
" }}}
" Languages {{{
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" {{{
  let g:coc_global_extensions = ['coc-tsserver']
  nnoremap <silent> K :call CocAction('doHover')<CR>
  nmap <leader>do <Plug>(coc-codeaction)
  nmap <leader>gd <Plug>(coc-definition)
  nmap <leader>rn <Plug>(coc-rename)

  " map 1-9 to nth item
  for s:i in range(1, 9)
    exe printf('inoremap <expr> %d pumvisible() ? <sid>select_pum(%d) : %d ', s:i, s:i, s:i)
  endfor

  function! s:select_pum(index)
    let compInfo = complete_info()
    let idx = a:index == 0 ? 10 : a:index - 1
    let d = idx - compInfo.selected
    return repeat( d > 0 ? "\<c-n>" : "\<c-p>", abs(d)) . "\<C-y>"
  endfunction

    if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
      let g:coc_global_extensions += ['coc-prettier']
    endif

    if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
      let g:coc_global_extensions += ['coc-eslint']
    endif
" }}}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'w0rp/ale'
" {{{
  let g:ale_fixers = {
  \   'javascript': ['prettier'],
  \}
  let g:ale_fix_on_save = 1
" }}}
" }}}

call plug#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = false,
    },
    ensure_installed = {'javascript'}
}
EOF

colorscheme darcula

" vim:foldmethod=marker:foldlevel=0
