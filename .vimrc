syntax on
" indent as previous line
set autoindent
" set tabs to spaces
set expandtab
" preferred spacing
set tabstop=2
set shiftwidth=2
" dont lookup indents for filetypes
filetype indent off
" set search highlight colors
set hlsearch
:hi Search ctermbg=LightBlue
:hi Search ctermfg=Black
:hi Serach guibg=LightBlue
:hi Search guifg=Black
" ignore case on search
set ignorecase
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"
" fd is now Esc when typed quickly
:imap fd <Esc>
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
