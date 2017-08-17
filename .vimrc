set nocompatible
syntax enable
set t_Co=256
color jellybeans
set number
set backspace=indent,eol,start
set autoindent
set copyindent
set showmatch
set smartcase
set hlsearch
set incsearch
set history=500
set undolevels=500
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set listchars=tab:>.,trail:.,extends:#,nbsp:.
autocmd filetype html,xml set listchars-=tab:>.
set pastetoggle=<F2>
inoremap jj <Esc>
nnoremap j gj
nnoremap k gk
" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
cmap w!! w !sudo tee % >/dev/null
augroup Shebang
  autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl># -*- coding: iso-8859-15 -*-\<nl>\"|$
  autocmd BufNewFile *.rb 0put =\"#!/usr/bin/env ruby\<nl># -*- coding: None -*-\<nl>\"|$
  autocmd BufNewFile *.tex 0put =\"%&plain\<nl>\"|$
  autocmd BufNewFile *.\(cc\|hh\) 0put =\"//\<nl>// \".expand(\"<afile>:t\").\" -- \<nl>//\<nl>\"|2|start!
augroup END
execute pathogen#infect()
