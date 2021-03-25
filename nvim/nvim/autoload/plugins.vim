call plug#begin('$HOME/.config/nvim/autoload/plugged') 

	" Coc Stuff
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	let g:coc_global_extensions = [
		\ 'coc-tsserver',
		\ 'coc-prettier',
		\ 'coc-eslint'
		\ ]

	" Language stuff
	Plug 'pangloss/vim-javascript'
	Plug 'leafgarland/typescript-vim'
	Plug 'peitalin/vim-jsx-typescript'
	Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
	Plug 'jparise/vim-graphql'
	Plug 'jiangmiao/auto-pairs'
	" Closetags
  Plug 'alvan/vim-closetag'


	
	" Nerd tree
  Plug 'preservim/nerdtree'

	"Easymotion
	Plug 'easymotion/vim-easymotion'

	" Theming:
	Plug 'nightsense/night-and-day'
	Plug 'ayu-theme/ayu-vim' 

	" Searching: 
	Plug 'ctrlpvim/ctrlp.vim'

call plug#end()
