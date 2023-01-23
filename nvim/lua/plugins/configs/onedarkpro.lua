return {
	"olimorris/onedarkpro.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("onedarkpro").setup({
			caching = true,
			theme = "onedark",
			colors = {
				bg = "#1F1F29",
			},
			options = {
				cursorline = false,
			},
		})

		vim.cmd("colorscheme onedark")
		vim.cmd("set bg=dark")
	end,
}
