nmap <leader>n :NERDTreeToggle <CR>

" Dont show node_modules and other unused dirs
let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$', '^node_modules$',]
" Show git stuff for files
let g:NERDTreeGitStatusWithFlags = 1
" Clean and nice UI
let NERDTreeMinimalUI = 1

set rtp+=~/.config/nvim/plugged/nerdtree/

augroup nerdtree
    autocmd!
    autocmd FileType nerdtree setlocal nolist         " turn off whitespace characters
    autocmd FileType nerdtree setlocal nocursorline   " turn off line highlighting for performance
augroup END

