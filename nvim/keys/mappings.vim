" g Leader key
let mapleader=" "
" let localleader=" "
nnoremap <Space> <Nop>

imap <C-h> <C-w>h
imap <C-j> <C-w>j
imap <C-k> <C-w>k
imap <C-l> <C-w>l


nmap <leader>q :q<CR>
nmap <leader>v :vnew<CR>
nmap <leader>w :w<CR>
nmap <leader>e :bn<CR>
nmap <leader>r :bp<CR>
nmap <leader>b :BD<CR>
noremap <C-q> :q<CR>
inoremap jj <ESC>

" Tabs
noremap <leader>a tabnew
" TAB in general mode will move to text buffer
nnoremap <silent> <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <silent> <S-TAB> :bprevious<CR>

" Switching tabs quickly
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>


" <TAB>: completion.
inoremap <silent> <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
