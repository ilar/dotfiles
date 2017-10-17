" Crucial
set nocompatible

" Basic settings.
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

" Handle indentation. 4 spaces behave like a tab, but aren't.
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

" Set list settings
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set list
autocmd filetype html,xml set listchars-=tab:>.

" F2 lets you toggle between
set pastetoggle=<F2>

" Macbook Pro specific- the esc 'button' is terrible.
inoremap jj <Esc>

" Move cursor by display lines, not real lines.
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Easy window/pane navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" w!! will try to sudo write.
cmap w!! w !sudo tee % >/dev/null

" Auto shebang and encoding embeds depending on filetype.
augroup Shebang
  autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl># -*- coding: iso-8859-15 -*-\<nl>\"|$
  autocmd BufNewFile *.rb 0put =\"#!/usr/bin/env ruby\<nl># -*- coding: None -*-\<nl>\"|$
  autocmd BufNewFile *.tex 0put =\"%&plain\<nl>\"|$
  autocmd BufNewFile *.\(cc\|hh\) 0put =\"//\<nl>// \".expand(\"<afile>:t\").\" -- \<nl>//\<nl>\"|2|start!
  autocmd FileType c,cpp,java,php,python autocmd BufWritePre <buffer> %s/\s\+$//e
augroup END

autocmd FileType python :set cc=110
autocmd FileType c,cpp,java,php,sh :set cc=80

" Easy addon management.
execute pathogen#infect()

" Local Machine Settings
source ${HOME}/.vimrc.local
