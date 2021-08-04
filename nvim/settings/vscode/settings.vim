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

xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

nnoremap <leader>w :Write<CR>
nnoremap <leader>t :Find<CR>

nnoremap <Tab> :Tabnext<CR>
nnoremap <S-Tab> :Tabprevious<CR> 
nnoremap <leader>do <Cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<CR>
nnoremap <leader>n <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>
nnoremap <leader>g <Cmd>call VSCodeNotify('workbench.view.scm')<CR>
nnoremap <leader>e <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>

nnoremap ln <CMD>call VSCodeNotify('editor.action.marker.next')<CR>
nnoremap lp <CMD>call VSCodeNotify('editor.action.marker.prev')<CR>


