call plug#begin('$HOME/.config/nvim/autoload/plugged') 

	" Coc Stuff
	Plug 'neoclide/coc.nvim', {'branch': 'release'}


	let g:coc_global_extensions = [
		\ 'coc-tsserver',
		\ 'coc-prettier',
		\ 'coc-eslint',
		\ 'coc-json'
		\ ]

	" Language stuff
	Plug 'pangloss/vim-javascript'
	Plug 'leafgarland/typescript-vim'
	Plug 'peitalin/vim-jsx-typescript'
	Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
	Plug 'jparise/vim-graphql'
	Plug 'jiangmiao/auto-pairs'
  Plug 'epilande/vim-es2015-snippets'
  Plug 'epilande/vim-react-snippets'
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
	Plug 'nightsense/night-and-day'
	Plug 'ayu-theme/ayu-vim' 
	Plug 'ap/vim-buftabline'


	" Searching: 
	" Plug 'ctrlpvim/ctrlp.vim'
  Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
  Plug 'junegunn/fzf.vim' " needed for previews
  Plug 'antoinemadec/coc-fzf'


call plug#end()
