"set nonumber
set noruler
syntax on

autocmd InsertEnter,InsertLeave * set cul!

:set number

"Pugins with vim-plug
set nocompatible
call plug#begin()
Plug 'sheerun/vim-polyglot'
Plug 'ayu-theme/ayu-vim' "
Plug 'lambdalisue/fern.vim'
call plug#end()

:colorscheme morning

"...
set termguicolors     " enable true colors support
let ayucolor="light"  " for light version of theme
"let ayucolor="mirage" " for mirage version of theme
"let ayucolor="dark"   " for dark version of theme
colorscheme ayu
