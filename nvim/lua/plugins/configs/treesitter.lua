require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"vim",
		"tsx",
		"typescript",
		"prisma",
	},
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	indent = { enable = true },
	autopairs = { enable = true },
	autotag = {
		enable = true,
	},
})
