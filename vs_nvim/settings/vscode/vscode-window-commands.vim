
function! s:split(...) abort
    let direction = a:1
    let file = exists('a:2') ? a:2 : ''
    call VSCodeCall(direction ==# 'h' ? 'workbench.action.splitEditorDown' : 'workbench.action.splitEditorRight')
  if !empty(file)
      call VSCodeExtensionNotify('open-file', expand(file), 'all')
  endif
endfunction

function! s:splitNew(...)
  let file = a:2
  call s:split(a:1, empty(file) ? '__vscode_new__' : file)
endfunction

function! s:closeOtherEditors()
  call VSCodeNotify('workbench.action.closeEditorsInOtherGroups')
  call VSCodeNotify('workbench.action.closeOtherEditors')
endfunction

function! s:manageEditorHeight(...)
  let count = a:1
  let to = a:2
  for i in range(1, count ? count : 1)
      call VSCodeNotify(to ==# 'increase' ? 'workbench.action.increaseViewHeight' : 'workbench.action.decreaseViewHeight')
  endfor
endfunction

function! s:manageEditorWidth(...)
  let count = a:1
  let to = a:2
  for i in range(1, count ? count : 1)
      call VSCodeNotify(to ==# 'increase' ? 'workbench.action.increaseViewWidth' : 'workbench.action.decreaseViewWidth')
  endfor
endfunction

command! -complete=file -nargs=? Split call <SID>split('h', <q-args>)
command! -complete=file -nargs=? Vsplit call <SID>split('v', <q-args>)
command! -complete=file -nargs=? New call <SID>split('h', '__vscode_new__')
command! -complete=file -nargs=? Vnew call <SID>split('v', '__vscode_new__')

AlterCommand sp[lit] Split
AlterCommand vs[plit] Vsplit
AlterCommand new New
AlterCommand vne[w] Vnew
AlterCommand on[ly] Only
AlterCommand explore

" buffer management
" nnoremap <leader>n <Cmd>call <SID>splitNew('v', '__vscode_new__')<CR>
" xnoremap <leader>n <Cmd>call <SID>splitNew('v', '__vscode_new__')<CR>

nnoremap <leader>n <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>
noremap <leader>n <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>

nnoremap <leader>q <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
xnoremap <leader>q <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
nnoremap <leader>c <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
xnoremap <leader>c <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
nnoremap <leader>x <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
xnoremap <leader>x <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
nnoremap <leader><C-c> <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
xnoremap <leader><C-c> <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>

" window/splits management 
nnoremap <leader>s <Cmd>call <SID>split('h')<CR>
xnoremap <leader>s <Cmd>call <SID>split('h')<CR>
nnoremap <leader><C-s> <Cmd>call <SID>split('h')<CR>
xnoremap <leader><C-s> <Cmd>call <SID>split('h')<CR>

nnoremap <leader>v <Cmd>call <SID>split('v')<CR>
xnoremap <leader>v <Cmd>call <SID>split('v')<CR>
nnoremap <leader><C-v> <Cmd>call <SID>split('v')<CR>
xnoremap <leader><C-v> <Cmd>call <SID>split('v')<CR>

nnoremap <leader>= <Cmd>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>
xnoremap <leader>= <Cmd>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>
nnoremap <leader>_ <Cmd>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>
xnoremap <leader>_ <Cmd>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>

nnoremap <leader>+ <Cmd>call <SID>manageEditorHeight(v:count, 'increase')<CR>
xnoremap <leader>+ <Cmd>call <SID>manageEditorHeight(v:count, 'increase')<CR>
nnoremap <leader>- <Cmd>call <SID>manageEditorHeight(v:count, 'decrease')<CR>
xnoremap <leader>- <Cmd>call <SID>manageEditorHeight(v:count, 'decrease')<CR>
nnoremap <leader>> <Cmd>call <SID>manageEditorWidth(v:count,  'increase')<CR>
xnoremap <leader>> <Cmd>call <SID>manageEditorWidth(v:count,  'increase')<CR>
nnoremap <leader>< <Cmd>call <SID>manageEditorWidth(v:count,  'decrease')<CR>
xnoremap <leader>< <Cmd>call <SID>manageEditorWidth(v:count,  'decrease')<CR>

nnoremap <leader>o <Cmd>call VSCodeNotify('workbench.action.joinAllGroups')<CR>
xnoremap <leader>o <Cmd>call VSCodeNotify('workbench.action.joinAllGroups')<CR>
nnoremap <leader><C-o> <Cmd>call VSCodeNotify('workbench.action.joinAllGroups')<CR>
xnoremap <leader><C-o> <Cmd>call VSCodeNotify('workbench.action.joinAllGroups')<CR>

" window navigation
nnoremap <leader>j <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
xnoremap <leader>j <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
nnoremap <leader>k <Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
xnoremap <leader>k <Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
nnoremap <leader>h <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
xnoremap <leader>h <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
nnoremap <leader>l <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
xnoremap <leader>l <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>

nnoremap <leader><Down> <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
xnoremap <leader><Down> <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
nnoremap <leader><Up> <Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
xnoremap <leader><Up> <Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
nnoremap <leader><Left> <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
xnoremap <leader><Left> <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
nnoremap <leader><Right> <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
xnoremap <leader><Right> <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>

nnoremap <leader><C-j> <Cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
xnoremap <leader><C-j> <Cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
nnoremap <leader><C-i> <Cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
xnoremap <leader><C-i> <Cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
nnoremap <leader><C-h> <Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
xnoremap <leader><C-h> <Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
nnoremap <leader><C-l> <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>
xnoremap <leader><C-l> <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>

nnoremap <leader><C-Down> <Cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
xnoremap <leader><C-Down> <Cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
nnoremap <leader><C-Up> <Cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
xnoremap <leader><C-Up> <Cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
nnoremap <leader><C-Left> <Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
xnoremap <leader><C-Left> <Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
nnoremap <leader><C-Right> <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>
xnoremap <leader><C-Right> <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>

nnoremap <leader><S-j> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupDown')<CR>
xnoremap <leader><S-j> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupDown')<CR>
nnoremap <leader><S-k> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupUp')<CR>
xnoremap <leader><S-k> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupUp')<CR>
nnoremap <leader><S-h> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupLeft')<CR>
xnoremap <leader><S-h> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupLeft')<CR>
nnoremap <leader><S-l> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupRight')<CR>
xnoremap <leader><S-l> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupRight')<CR>

nnoremap <leader><S-Down> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupDown')<CR>
xnoremap <leader><S-Down> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupDown')<CR>
nnoremap <leader><S-Up> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupUp')<CR>
xnoremap <leader><S-Up> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupUp')<CR>
nnoremap <leader><S-Left> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupLeft')<CR>
xnoremap <leader><S-Left> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupLeft')<CR>
nnoremap <leader><S-Right> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupRight')<CR>
xnoremap <leader><S-Right> <Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupRight')<CR>

" nnoremap <leader>w <Cmd>call VSCodeNotify('workbench.action.focusNextGroup')<CR>
" xnoremap <leader>w <Cmd>call VSCodeNotify('workbench.action.focusNextGroup')<CR>
nnoremap <leader><C-w> <Cmd>call VSCodeNotify('workbench.action.focusNextGroup')<CR>
xnoremap <leader><C-w> <Cmd>call VSCodeNotify('workbench.action.focusNextGroup')<CR>
nnoremap <leader>W <Cmd>call VSCodeNotify('workbench.action.focusPreviousGroup')<CR>
xnoremap <leader>W <Cmd>call VSCodeNotify('workbench.action.focusPreviousGroup')<CR>
nnoremap <leader>p <Cmd>call VSCodeNotify('workbench.action.focusPreviousGroup')<CR>
xnoremap <leader>p <Cmd>call VSCodeNotify('workbench.action.focusPreviousGroup')<CR>

" nnoremap <leader>t <Cmd>call VSCodeNotify('workbench.action.focusFirstEditorGroup')<CR>
" xnoremap <leader>t <Cmd>call VSCodeNotify('workbench.action.focusFirstEditorGroup')<CR>
" nnoremap <leader>b <Cmd>call VSCodeNotify('workbench.action.focusLastEditorGroup')<CR>
" xnoremap <leader>b <Cmd>call VSCodeNotify('workbench.action.focusLastEditorGroup')<CR>



nnoremap <leader>g <Cmd>call VSCodeNotify('workbench.view.scm')<CR>
xnoremap <leader>g <Cmd>call VSCodeNotify('workbench.view.scm')<CR>

nnoremap <leader>fw <Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>
xnoremap <leader>fw <Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>


