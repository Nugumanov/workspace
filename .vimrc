"set nonumber
set noruler
syntax on

"colorscheme tim
"set background=dark
"autocmd ColorScheme tim highlight normal ctermbg=235
"highligh Normal
"autocmd InsertEnter * highlight Normal ctermbg=17
"autocmd InsertLeave * highlight Normal ctermbg=16
"autocmd InsertEnter * set cul
"autocmd InsertLeave * set nocul
"
autocmd InsertEnter,InsertLeave * set cul!

:set number

"Pugins with vim-plug
set nocompatible
call plug#begin()
Plug 'sheerun/vim-polyglot'
call plug#end()

:colorscheme morning
