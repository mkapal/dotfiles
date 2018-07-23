set termguicolors
colorscheme darcula
syntax on
set expandtab
set smarttab
set tabstop=2
set shiftwidth=2

" Try the following if your GUI uses a dark background.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen

" Show trailing whitepace and spaces before a tab:
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

