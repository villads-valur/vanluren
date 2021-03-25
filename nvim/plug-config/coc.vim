" Map completion to Tab
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Navigate snippet placeholders using tab
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" list of the extensions required
let g:coc_global_extensions = [
            \'coc-yank',
            \'coc-actions',
            \'coc-pairs',
            \'coc-json',
            \'coc-css',
            \'coc-html',
            \'coc-tsserver',
            \'coc-lists',
            \'coc-snippets',
            \'coc-ultisnips',
            \'coc-python',
            \'coc-prettier',
            \'coc-eslint',
            \'coc-syntax',
            \'coc-git',
            \'coc-emmet',
            \'coc-vimlsp',
            \'coc-styled-components'
            \]


" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')" Show documentation

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

function! s:show_documentation() 
    call CocAction('doHover')
 endfunction

 function s:FormatAll() 
    call CocAction('format')
    call CocAction('runCommand', 'editor.action.organizeImport')
 endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Key Bindings
map <silent> gd <Plug>(coc-definition)
map <silent> gy <Plug>(coc-type-definition)
map <silent> gi <Plug>(coc-implementation)
map <silent> gr <Plug>(coc-references)
map <silent> gh :call <SID>show_documentation()<CR>
map <silent> lp <Plug>(coc-diagnostic-prev)
map <silent> ln <Plug>(coc-diagnostic-next)
" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>a  <Plug>(coc-fix-current)

" Show autocomplete when Tab is pressed
inoremap <silent><expr> <Tab> coc#refresh()"

" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
