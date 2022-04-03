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
	autotag = {
		enable = true,
		filetypes = {
			"html",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
			"vue",
			"tsx",
			"jsx",
			"rescript",
			"xml",
		},
	},
})
