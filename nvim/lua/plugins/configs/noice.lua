return {
	"folke/noice.nvim",
	config = function()
		require("noice").setup({
			routes = {
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "written",
					},
					opts = { skip = true },
				},
				{
					filter = {
						event = "msg_show",
						kind = "search_count",
					},
					opts = { skip = true },
				},
			},
		})
	end,
	requires = {
		"MunifTanjim/nui.nvim",
	},
}
