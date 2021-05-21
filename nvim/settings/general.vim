" General:
syntax enable 			" Enable syntax higlighting
set number					" Show linenumbers
set encoding=UTF-8 	" Use UTF-8
set nowrap          " Display long lines as just one line
set noswapfile			" Don't set SWP files 
set nowb
set mouse=a 				" Set mouse usage to all
set lazyredraw 			" Performance 

" Splitting:
set splitbelow                         	" Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right

" Status:
set noshowmode				                  " Dont show --INSERT-- in the small status line

" Colors:
set t_Co=256                            " Support 256 colors
set termguicolors                       " enable true colors support

" Writing:
set conceallevel=0                      " So that I can see `` in markdown files
set clipboard=unnamedplus  							" Use the same clipboard for anything
set cursorline                          " Enable highlighting of the current line
set expandtab 													" Use spaces over tabs
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set shiftwidth=2	 											" 2 space for a tab
set tabstop=2                           " Insert 2 spaces for a tab
set showtabline=2												" TODO
set updatetime=300											" Wait 750 ms after typing to update
set smartindent 												" TODO
set cmdheight=2 												" TODO
set showmatch 													" Show matching brackets

" Searching:
set ignorecase 													" Ignore case when searching
set smartcase 													" When searching try to be smart about cases

" Mappings:
let mapleader=" "
nnoremap <Space> <Nop>

imap <C-h> <C-w>h
imap <C-j> <C-w>j
imap <C-k> <C-w>k
imap <C-l> <C-w>l


nmap <leader>q :q<CR>
nmap <leader>v :vnew<CR>
nmap <leader>w :w<CR>
nmap <leader>e :BF<CR>
nmap <leader>r :BB<CR>
nmap <leader>b :BD<CR>
noremap <C-q> :q<CR>
inoremap jj <ESC>

" TAB in general mode will move to text buffer
nnoremap <silent> <TAB> :bnext<CR>

" SHIFT-TAB will go back
nnoremap <silent> <S-TAB> :bprevious<CR>

" Tabs
noremap <leader>a tabnew

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

" Remap P to paste without yank
xnoremap P Pgvy

" Syntax on when entering a file
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
" Syntax off when exiting
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" Return to last edit position when opening files 
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Source Vim configuration file and install plugins
nnoremap <silent><leader>1 :source ~/.config/nvim/init.vim \| :PlugInstall<CR>
" Open Vim configuration file for editing
nnoremap <silent><leader>2 :e ~/.config/nvim/init.vim<CR>
