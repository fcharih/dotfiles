
" Fix weird backspace behavior
set backspace=indent,eol,start

" Sensible screen splitting defaults
set splitbelow
set splitright

" Indentation
setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType c setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType java setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType cpp setlocal ts=4 sts=4 sw=4 expandtab


set clipboard=unnamed

set ignorecase