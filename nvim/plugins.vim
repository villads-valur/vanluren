call plug#begin('$HOME/.config/nvim/autoload/plugged') 

	" Coc Stuff
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

  let g:coc_global_extensions = [
		\ 'coc-tsserver',
		\ 'coc-prettier',
		\ 'coc-eslint',
		\ 'coc-json',
		\ 'coc-css',
	  \ 'coc-html',
		\ 'coc-snippets',
    \ 'coc-emmet'
		\ ]


	" Language stuff
	Plug 'pangloss/vim-javascript'
	Plug 'leafgarland/typescript-vim'
	Plug 'peitalin/vim-jsx-typescript'
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
	Plug 'ap/vim-buftabline'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'bling/vim-bufferline'

	" Searching: 
  Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
  Plug 'junegunn/fzf.vim' " needed for previews
  Plug 'antoinemadec/coc-fzf'
