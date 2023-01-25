return {
	"nvim-treesitter/nvim-treesitter",
	opts = function()
		return {
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
		}
	end,
}
