require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"vim",
		"tsx",
	},
	highlight = {
		enable = true,
		use_languagetree = true,
	},
})
