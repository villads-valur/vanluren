return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "html", "css", "tsx", "typescript", "lua", "vim", "help" },
		})
	end,
}
