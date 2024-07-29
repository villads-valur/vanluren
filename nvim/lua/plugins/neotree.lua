return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	keys = function()
		return {
			{
				"<leader>fe",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
			{ "<leader>n", "<leader>fE", desc = "Explorer NeoTree", remap = true },
			{ "<leader>N", "<leader>fe", desc = "Explorer NeoTree (root)", remap = true },
		}
	end,
	opts = {
		filesystem = {
			bind_to_cwd = true,
			follow_current_file = {
				enabled = false,
			},
			use_libuv_file_watcher = true,
		},
		window = {
			mappings = {
				["<space>"] = "none",
			},
			position = "right",
		},
		default_component_configs = {
			indent = {
				with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
		},
	},
}
