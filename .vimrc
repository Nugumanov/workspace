syntax on
set encoding=UTF-8
vmap <C-c> :w !pbcopy<CR><CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
autocmd InsertEnter,InsertLeave * set cul!
"set ruler
"set showtabline=1
set list
set listchars=tab:•\ ,trail:•,extends:»,precedes:«

let &t_SI = "\e[5 q"
let &t_EI = "\e[5 q"


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
Plug 'roman/golden-ratio'
Plug 'rust-lang/rust.vim'
Plug 'knubie/vim-kitty-navigator'
Plug 'tpope/vim-fugitive'
call plug#end()

" Rust recommendations
syntax enable
filetype plugin indent on
"-----------------------------------------------"


" LINE NUMBERS
"-----------------------------------------------"
"PAY ATTENTION: here is space at the end of the line:
set fillchars=vert:\ "and this is ok =)

set nonumber
set numberwidth=7
autocmd BufEnter * setlocal number
autocmd BufEnter * setlocal relativenumber
autocmd BufLeave * setlocal nonumber
autocmd BufLeave * setlocal norelativenumber
"-----------------------------------------------"


" COLORS
"-----------------------------------------------"
set cursorline
set termguicolors     " enable true colors support
set background=dark
let g:gruvbox_italic=0
colorscheme gruvbox
"autocmd ColorScheme * :TmuxlineSnapshot! ~/.tmux/configs/tmuxline.conf
"set showtabline=2

" force transparent vim background, not needed if you dont use terminal transparency
"hi Normal guibg=NONE ctermbg=NONE
"-----------------------------------------------"


" AIRLINE
"-----------------------------------------------"
let g:airline_theme='gruvbox'

function! AirlineBuffMove ()
  "let g:airline_section_a = ''
  let g:airline_section_b = '%{getcwd()}' " in section B of the status line display the CWD
  let g:airline_section_c = ''
  let g:airline_section_x = ''
  let g:airline_section_y = ''
  let g:airline_section_z = ''
endfunction

augroup BuffConfig
  autocmd!
  autocmd BufEnter * call AirlineBuffMove()
augroup END

"let g:airline_powerline_fonts = 0
"let g:airline_detect_iminsert=0
"let g:airline_inactive_collapse=1
"let g:airline_focuslost_inactive = 1

" tabline
"let g:airline#extensions#tabline#enabled = 1           " enable airline tabline
"let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline
"let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
"let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)
"let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab
"let g:airline#extensions#tabline#show_tab_count = 0    " dont show tab numbers on the right
"
"let g:airline#extensions#tabline#show_buffers = 1
"let g:airline#extensions#tabline#tab_min_count = 2     " minimum of 2 tabs needed to display the tabline
"let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline
"let g:airline#extensions#tabline#show_tab_nr = 0       " disable tab numbers
"let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird ornage arrow on the tabline
"
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline#extensions#tabline#formatter = 'unique_tail'
"-----------------------------------------------"


" FERN
"-----------------------------------------------"
let g:fern#disable_default_mappings = 1
let g:fern#default_hidden = 1

function! SetupVimLayout()
  Fern . -drawer -toggle -width=35 -reveal=%
  wincmd l
  vsplit
  wincmd l
  execute argc() == 0 ? 'enew': (argc() == 1 ? 'enew' : 'e ' . argv(1))
  wincmd h
endfunction

function! s:fern_settings() abort
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
  nmap <buffer> V <Plug>(fern-action-open:vsplit)
  nmap <buffer> H <Plug>(fern-action-open:split)
  nmap <buffer> S <Plug>(fern-action-open:select)
  nmap <buffer> M <Plug>(fern-action-move)
  nmap <buffer> <Space> <Plug>(fern-action-mark:toggle)
  nmap <buffer> dd <Plug>(fern-action-trash)
  nmap <buffer> T <Plug>(fern-action-new-file)
  nmap <buffer> R <Plug>(fern-action-rename)
  nmap <buffer> <C-l> <C-w>l
  nmap <buffer> l <Plug>(fern-action-open-or-expand)
  nmap <buffer> h <Plug>(fern-action-collapse)
  nmap <buffer> <CR> <Plug>(fern-action-enter)
  nmap <buffer> <BACKSPACE> <Plug>(fern-action-leave)
endfunction

augroup fern-startup
  autocmd!
  autocmd VimEnter * ++nested call SetupVimLayout()
augroup END

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

function! FernChangeDir(path)
  execute 'cd' fnameescape(a:path)
endfunction

let g:fern#hook#leaf#open = function('FernChangeDir')
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

