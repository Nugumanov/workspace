syntax on
set encoding=UTF-8
vmap <C-c> :w !pbcopy<CR><CR>
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
autocmd InsertEnter,InsertLeave * set cul!
set ruler
set showtabline=1
set termwinsize=10x0

" open terminal below all splits
cabbrev bterm bo term



" LINE NUMBERS
"-----------------------------------------------"
set number
set relativenumber
set numberwidth=20
"-----------------------------------------------"



" PLUGINS
"-----------------------------------------------"
set nocompatible
call plug#begin()
Plug 'sheerun/vim-polyglot'
Plug 'lambdalisue/fern.vim'
Plug 'yuki-yano/fern-preview.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
call plug#end()
"-----------------------------------------------"



" COLORS
"-----------------------------------------------"
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set termguicolors     " enable true colors support
set background=dark

let g:gruvbox_italic=0
colorscheme gruvbox
"autocmd ColorScheme * :TmuxlineSnapshot! ~/.tmux/configs/tmuxline.conf

set showtabline=2
let g:airline_theme='gruvbox'

" force transparent vim background, not needed if you dont use terminal transparency
"hi Normal guibg=NONE ctermbg=NONE
"-----------------------------------------------"



" AIRLINE
"-----------------------------------------------"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
"let g:airline_section_x = ''
let g:airline_section_y = 'eol'
 "let g:airline_section_<name>
 "let g:airline_section_<name>
 "let g:airline_section_<name>
 "let g:airline_section_<name>
 "let g:airline_section_<name>
 "let g:airline_section_<name>
 "let g:airline_section_<name>
"-----------------------------------------------"



 "" TMUXLINE
 ""-----------------------------------------------"
 "let g:tmuxline_powerline_separators = 0
 "let g:tmuxline_preset = {
 "	\ 'a': '#S',
 "        \ 'win': '#I: #W',
 "        \ 'cwin': '#I: #W',
 "	\ 'y': '#(spotify status artist) - #(spotify status track)',
 "        \ 'z': '%d %b %H:%M',
 "        \ 'options': {
 "        \'status-justify': 'left'}
 "	\}
 ""-----------------------------------------------"
 "


" FERN
"-----------------------------------------------"
let g:fern#disable_default_mapping = 1
let g:fern#default_hidden = 1

function! FernInit() abort
  nmap <buffer> N <Plug>(fern-action-new-path)
  nmap <buffer> dd <Plug>(fern-action-trash)
  nmap <buffer> T <Plug>(fern-action-new-file)
  nmap <buffer> M <Plug>(fern-action-move)
  nmap <buffer> R <Plug>(fern-action-rename)
  nmap <buffer> K <Plug>(fern-action-mark-toggle)
  map <buffer> H <Plug>(fern-action-open:split)
  nmap <buffer> V <Plug>(fern-action-aopen:vsplit)
  nmap <buffer><nowait> < <Plug>(fern-action-leave)
  nmap <buffer><nowait> > <Plug>(fern-action-enter)
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

augroup my-fern-startup
  autocmd!
  autocmd VimEnter * ++nested if argc() == 0 | exec "Fern . -drawer -toggle -reveal=% -width=35" | else | exec "Fern . -drawer -toggle -width=35" | wincmd p | endif
augroup END

" fern preview
function! s:fern_settings() abort
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
endfunction
"-----------------------------------------------"



" CYCLE COLORS
"-----------------------------------------------"
let g:colors = getcompletion('', 'color')
func! NextColors()
    let idx = index(g:colors, g:colors_name)
    return (idx + 1 >= len(g:colors) ? g:colors[0] : g:colors[idx + 1])
endfunc
func! PrevColors()
    let idx = index(g:colors, g:colors_name)
    return (idx - 1 < 0 ? g:colors[-1] : g:colors[idx - 1])
endfunc
nnoremap <F1> :exe "colo " . PrevColors()<CR>
nnoremap <F2> :exe "colo " . NextColors()<CR>
"-----------------------------------------------"

