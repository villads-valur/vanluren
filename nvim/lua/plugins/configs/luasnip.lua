return {
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip").filetype_extend("javascriptreact", { "html" })
			require("luasnip").filetype_extend("typescriptreact", { "html" })
			require("luasnip").filetype_extend("typescriptreact", { "javascript" })
			require("luasnip").filetype_extend("typescript", { "javascript" })
		end,
	},
	{ "rafamadriz/friendly-snippets" },
}
