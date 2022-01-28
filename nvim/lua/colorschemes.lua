vim.cmd([[
	if strftime("%H") < 17
	  set background=light
	  colorscheme ayu-light
	else
	  set background=dark
	  colorscheme onedarker 
	endif
]])
