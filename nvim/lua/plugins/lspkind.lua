return {
	"onsails/lspkind.nvim",

	enabled = vim.g.icons_enabled,
	config = function(_, opts)
		require("lspkind").init(opts)
	end,
}
