call plug#begin('$HOME/.config/nvim/autoload/plugged') 

	" Coc Stuff
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	" Language stuff
	Plug 'pangloss/vim-javascript'
	Plug 'leafgarland/typescript-vim'
	Plug 'peitalin/vim-jsx-typescript'
  Plug 'heavenshell/vim-jsdoc', { 
    \ 'for': ['javascript', 'javascript.jsx','typescript'], 
    \ 'do': 'make install'
  \}	

  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
	Plug 'jparise/vim-graphql'
	Plug 'jiangmiao/auto-pairs'
  Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }	
	
	" tpope stuff 
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'

	" Closetags
  Plug 'alvan/vim-closetag'
	
	" Nerd tree
  Plug 'preservim/nerdtree'
	Plug 'ryanoasis/vim-devicons'
  
	"Easymotion
	Plug 'easymotion/vim-easymotion'

	" Theming:
	Plug 'ayu-theme/ayu-vim' 
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'edkolev/tmuxline.vim'

	" Searching: 
  Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
  Plug 'junegunn/fzf.vim' " needed for previews
  Plug 'antoinemadec/coc-fzf'

  " Othe stuff
  Plug 'qpkorr/vim-bufkill'

  call plug#end()
