
" Fix weird backspace behavior
set backspace=indent,eol,start

" Sensible screen splitting defaults
set splitbelow
set splitright

" Indentation
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType js setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType xml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType jsx setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType tsx setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType scss setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType c setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType java setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType cpp setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType tex setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType vim setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType sql setlocal ts=2 sts=2 sw=2 expandtab

set clipboard=unnamed
