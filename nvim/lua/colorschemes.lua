require("onedark").setup({
	style = "darker",
})
require("onedark").load()

vim.cmd([[
	if strftime("%H") < 17
	  set background=light
	  colorscheme ayu-light
	else
	  set background=dark
	  colorscheme onedark
	endif
]])
