local currentTime = os.date("*t")

if currentTime.hour >= 8 and currentTime.hour >= 17 then
	vim.opt.background = "dark"

	require("onedark").setup({
		style = "darker",
	})

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
