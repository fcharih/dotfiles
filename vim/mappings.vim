" Remap leader key
let mapleader=" "

" Remap escape key to kj
inoremap kj <Esc>

" For autocompletion (I don't want to use dem arrows!)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Normal mode
nnoremap <C-t> :split\|term<Enter>
nnoremap <C-x> <C-w>
nnoremap <Leader>ll :bnext<Enter> " Next buffer
nnoremap <Leader>hh :bprevious<Enter> " Previous buffer
nnoremap <Leader>ff :FZF<Enter>
nnoremap <leader>ft :FloatermNew<Enter>
nnoremap <leader>q :q!<Enter>
nnoremap <leader>r :RnvimrToggle<Enter>
nmap <space>e :CocCommand explorer<CR>

nnoremap <leader>d "_d

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Visual mode
vnoremap < <gv " Keep selection after indenting!
vnoremap > >gv

" Terminal mode
tnoremap <Esc> <c-\><c-n>
tnoremap kj <c-\><c-n>

xnoremap <leader>d "_d
xnoremap <leader>p "_dP

" Saving and quitting...
:command WQ wq
:command Wq wq
:command W w
:command Q q

