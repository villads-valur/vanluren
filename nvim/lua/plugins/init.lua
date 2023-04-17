local import = function(name)
	return { import = "plugins.configs." .. name }
end

local plugins = {
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"folke/neodev.nvim",
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	"MunifTanjim/nui.nvim",
	import("telescope"),
	import("neotree"),
	import("neotree"),
	import("onedarkpro"),
	import("noice"),
	import("dressing"),
	import("alpha"),
	import("hop"),
	import("tpope-essentials"),
	import("bufferline"),
	import("buf-remove"),
	import("lsp"),
	import("treesitter"),
	import("mini"),
	import("lualine"),
	import("indent-blankline"),
	import("gitsigns"),
	import("ts-autotag"),
	import("luasnip"),
	import("null-ls"),
	import("cmp"),
	import("lspkind"),
	import("zen"),
	import("ayu"),
	import("dark-notify"),
	import("colorizer"),
	import("copilot"),
}

require("lazy").setup(plugins)
