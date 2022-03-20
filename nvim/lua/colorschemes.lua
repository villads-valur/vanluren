local currentTime = os.date("*t")

if currentTime.hour >= 8 and currentTime.hour >= 16 then
	require("onedark").setup({
		style = "darker",
	})

	vim.opt.background = "dark"

	require("onedark").load()

	vim.cmd("colorscheme onedark")
else
	vim.opt.background = "light"

	require("ayu").setup({
		mirage = false,
		overrides = {},
	})
	vim.cmd("colorscheme ayu-light")
end
