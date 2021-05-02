let hour = strftime("%H")

if 6 <= hour && hour < 18
  let ayucolor="light"  " for light version of theme
  let g:airline_theme="ayu_light"
  set background=light
else
  let ayucolor="mirage"  " for light version of theme
  let g:airline_theme="ayu_mirage"
  set background=dark
  
endif

let g:indentLine_char = ' '
let g:indentLine_first_char = ' '
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0

colorscheme ayu


