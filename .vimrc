"" Franglois' vimrc
"" Author: Francois Charih <francois.charih@gmail.com>
"" Created: March 24, 2018
"
"
""==========> KEYMAPS <============
""
" 'cause my fingaz are lazy!
"
inoremap kj <Esc>

" For autocompletion (I don't want to use dem arrows!)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Normal mode
nnoremap <C-t> :split\|term<Enter>
nnoremap <C-x> <C-w>
nnoremap <C-f><C-f> :FZF<Enter>

" Visual mode
:vnoremap < <gv " Keep selection after indenting!
:vnoremap > >gv

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

" USE OS CLIPBOARD (works on Linux)
set clipboard=unnamedplus

"=================================

"==========> BEHAVIOR <===========
"
" My tabs stuff
"

" Split the window below and to the right, kind of odd this is not the default IMHO
set splitbelow
set splitright
""=================================
"
""==========> PLUGINS <============
""
"" 'cause you oughta plug it!
""
call plug#begin('~/.vim/plugged')
Plug 'YorickPeterse/happy_hacking.vim'
Plug 'vim-airline/vim-airline'
Plug 'rakr/vim-two-firewatch'

" Completion stuff
"if has('nvim')
"  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
"  Plug 'Shougo/deoplete.nvim'
"  Plug 'roxma/nvim-yarp'
"  Plug 'roxma/vim-hug-neovim-rpc'
"endif
"let g:deoplete#enable_at_startup = 1
"
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " Fuzzyfinder
"Plug 'zchee/deoplete-jedi' " Python autocompletion
Plug 'davidhalter/jedi-vim'
Plug 'rstacruz/vim-closer' " auto-close parens

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
Plug 'ipod825/vim-netranger'

"" Snippets stuff
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsSnippetDirectories=[$HOME.'/dotfiles/.vim/mysnippets']
let g:UltiSnipsEditSplit="vertical"

"" React js stuff
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" Ale
Plug 'w0rp/ale'

"" Colors :)
Plug 'chriskempson/base16-vim'
call plug#end()
""=================================
""
"
"" Random sheetz below
"set nocompatible              " be iMproved, required
"filetype off                  " required
"
"filetype plugin indent on    " required
"set shiftwidth=2
"set softtabstop=2
"set tabstop=2
"
autocmd FileType python setlocal ts=4 sts=4 sw=4
autocmd FileType javascript setlocal ts=2 sts=2 sw=2
autocmd FileType c setlocal ts=4 sts=4 sw=4 expandtab
"
"" React files
""au BufNewFile,BufRead *.jsx setlocal ft=html ft=javascript
"
"
"" Activate syntax highlighting
"syntax enable
"syntax on
"
""colorscheme base16-default-dark
"
"" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
"filetype plugin on
"
"" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
"" can be called correctly.
"set shellslash
"
"" OPTIONAL: This enables automatic indentation as you type.
"filetype indent on
"
"" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
"" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
"" The following changes the default filetype back to 'tex':
"let g:tex_flavor='latex'
"
" For proper React coloring (https://github.com/mxw/vim-jsx/issues/124)
hi Tag        ctermfg=04
hi xmlTag     ctermfg=04
hi xmlTagName ctermfg=04
hi xmlEndTag  ctermfg=04

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
"
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

set background=dark " or light if you prefer the light version
let g:two_firewatch_italics=1
color two-firewatch

let g:airline_theme='twofirewatch' " if you have Airline installed and want the associated theme

highlight Pmenu ctermbg=gray guibg=gray

