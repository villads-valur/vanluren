" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

  " Have the file system follow you around
  Plug 'airblade/vim-rooter'
  " auto set indent settings
  Plug 'tpope/vim-sleuth'

  if exists('g:vscode')
    " Easy motion for VSCode
    Plug 'asvetliakov/vim-easymotion'

  else
    " Text Navigation
    Plug 'easymotion/vim-easymotion'
    " Add some color
       Plug 'junegunn/rainbow_parentheses.vim'
    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " Cool Icons
    Plug 'ryanoasis/vim-devicons'
    " Auto pairs for '(' '[' '{' 
    Plug 'jiangmiao/auto-pairs'
    " Closetags
    Plug 'alvan/vim-closetag'
 
  " Colorscheme
  Plug 'vim-airline/vim-airline'                          " airline status bar
  Plug 'ryanoasis/vim-devicons'                           " pretty icons everywhere
  Plug 'hzchirs/vim-material'                             " material color themes
  Plug 'mhinz/vim-startify'                               " Fancy startpage 

  " Status Line
  Plug 'vim-airline/vim-airline'
  " Plug 'vim-airline/vim-airline-themes'
   
  " Intellisense
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
  
  " FZF
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  
  "NERDTree
  Plug 'scrooloose/nerdtree', {'on':['NERDTreeToggle', 'NERDTreeFind']} 
  Plug 'Xuyuanp/nerdtree-git-plugin'

  " Git
  Plug 'airblade/vim-gitgutter'

 " Snippets
  Plug 'SirVer/ultisnips'
  Plug 'epilande/vim-es2015-snippets'
  Plug 'epilande/vim-react-snippets'
  Plug 'honza/vim-snippets'
  Plug 'mattn/emmet-vim'

  " Tpope(and others) Essentials
  Plug 'tpope/vim-commentary'                             " better commenting
  Plug 'tpope/vim-fugitive'                               " git support
  Plug 'tpope/vim-ragtag'                                 " endings for html, xml, etc  
  Plug 'tpope/vim-surround'                               " endings for html, xml, etc 
  Plug 'tpope/vim-repeat'                                 " endings for html, xml, etc 
  Plug 'tpope/vim-endwise'                                " endings for html, xml, etc 
  Plug 'qpkorr/vim-bufkill'

  endif


call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
