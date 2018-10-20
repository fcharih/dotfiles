" Franglois' vimrc
" Author: Francois Charih <francois.charih@gmail.com>
" Created: March 24, 2018


"==========> KEYMAPS <============
"
" 'cause my fingaz are lazy!
"
inoremap kj <Esc>

" For autocompletion (I don't want to use dem arrows!)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Normal mode
nnoremap <C-t> :split\|term<Enter>
nnoremap <C-x> <C-w>

" Terminal mode
tnoremap <Esc> <c-\><c-n>
tnoremap kj <Esc>

" Saving and quitting...
:command WQ wq
:command Wq wq
:command W w
:command Q q

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"=================================

"==========> BEHAVIOR <===========
"
" My tabs stuff
"

" Split the window below and to the right, kind of odd this is not the default IMHO
set splitbelow
set splitright
"=================================

"==========> PLUGINS <============
"
" 'cause you oughta plug it!
"
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'

" Completion stuff
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " Fuzzyfinder
Plug 'zchee/deoplete-jedi' " Python autocompletion

"NERDTree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

"Boss syntax highlighting
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['latex'] 

" LaTeX support
Plug 'lervag/vimtex'

" Git plugin
Plug 'jreybert/vimagit'

" Misc
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'

"" Snippets stuff
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]
let g:UltiSnipsEditSplit="vertical"

"" React js stuff
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

"" Colors :)
Plug 'chriskempson/base16-vim'
call plug#end()
"=================================
"

" Random sheetz below
set nocompatible              " be iMproved, required
filetype off                  " required

filetype plugin indent on    " required
autocmd FileType tex setlocal shiftwidth=2 tabstop=2
autocmd FileType json setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal ts=2 sts=2 sw=2

" React files
"au BufNewFile,BufRead *.jsx setlocal ft=html ft=javascript


" Activate syntax highlighting
syntax enable
syntax on

colorscheme base16-default-dark

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" For proper React coloring (https://github.com/mxw/vim-jsx/issues/124)
hi Tag        ctermfg=04
hi xmlTag     ctermfg=04
hi xmlTagName ctermfg=04
hi xmlEndTag  ctermfg=04
