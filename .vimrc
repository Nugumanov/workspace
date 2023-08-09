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

call plug#begin()
Plug 'preservim/NERDTree'
call plug#end()
