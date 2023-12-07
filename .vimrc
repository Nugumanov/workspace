syntax on
set encoding=UTF-8
set ruler
set relativenumber

" Relative number for focused buffer
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

vmap <C-c> :w !pbcopy<CR><CR>

autocmd InsertEnter,InsertLeave * set cul!

"Pugins with vim-plug
set nocompatible
call plug#begin()
Plug 'sheerun/vim-polyglot'
Plug 'ayu-theme/ayu-vim'
Plug 'lambdalisue/fern.vim'
call plug#end()

" Setup colors
set termguicolors     " enable true colors support
"let ayucolor="dark"
"let ayucolor="mirage"
let ayucolor="light"
colorscheme ayu

" Fern
let g:fern#disable_default_mapping = 1
let g:fern#default_hidden = 1

function! FernInit() abort
  nmap <buffer> N <Plug>(fern-action-new-path)
  nmap <buffer> dd <Plug>(fern-action-trash)
  nmap <buffer> T <Plug>(fern-action-new-file)
  nmap <buffer> M <Plug>(fern-action-move)
  nmap <buffer> R <Plug>(fern-action-rename)
  nmap <buffer> K <Plug>(fern-action-mark-toggle)
  nmap <buffer> H <Plug>(fern-action-open:split)
  nmap <buffer> V <Plug>(fern-action-aopen:vsplit)
  nmap <buffer><nowait> <  <Plug>(fern-action-leave)
  nmap <buffer><nowait> > <Plug>(fern-action-enter)
endfunction

augroup my-fern-startup
  autocmd! *
  autocmd VimEnter * ++nested Fern . -drawer -toggle -width=35 -reveal=%
augroup END

" Cycle through colors
let g:colors = getcompletion('', 'color')
func! NextColors()
    let idx = index(g:colors, g:colors_name)
    return (idx + 1 >= len(g:colors) ? g:colors[0] : g:colors[idx + 1])
endfunc
func! PrevColors()
    let idx = index(g:colors, g:colors_name)
    return (idx - 1 < 0 ? g:colors[-1] : g:colors[idx - 1])
endfunc
nnoremap <C-n> :exe "colo " .. NextColors()<CR>
nnoremap <C-p> :exe "colo " .. PrevColors()<CR>

