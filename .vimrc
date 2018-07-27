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
Plug 'YorickPeterse/happy_hacking.vim'
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

"" Snippets stuff
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]
let g:UltiSnipsEditSplit="vertical"

call plug#end()
"=================================
"

" Random sheetz below
set nocompatible              " be iMproved, required
filetype off                  " required

filetype plugin indent on    " required
autocmd FileType tex setlocal shiftwidth=2 tabstop=2
autocmd FileType json setlocal shiftwidth=2 tabstop=2


" Activate syntax highlighting
syntax enable
syntax on

" THEME
color happy_hacking

