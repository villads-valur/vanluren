return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	events = { "VimEnter" },
	keys = {
		{ "<leader>t", ":Telescope git_files<CR>", desc = "Find Files (root)" },
		{ "<leader>T", ":Telescope find_files<CR>", desc = "Find Files (cwd)" },
		{ "<leader>/", ":Telescope live_grep<CR>", desc = "Find string in files" },
	},
	opts = function()
		local actions = require("telescope.actions")
		local open_with_trouble = function(...)
			return require("trouble.sources.telescope").open(...)
		end

		return {
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				get_selection_window = function()
					local wins = vim.api.nvim_list_wins()
					table.insert(wins, 1, vim.api.nvim_get_current_win())
					for _, win in ipairs(wins) do
						local buf = vim.api.nvim_win_get_buf(win)
						if vim.bo[buf].buftype == "" then
							return win
						end
					end
					return 0
				end,
				mappings = {
					i = {
						["<c-t>"] = open_with_trouble,
						["<a-t>"] = open_with_trouble,
						["<a-i>"] = find_files_no_ignore,
						["<a-h>"] = find_files_with_hidden,
						["<C-Down>"] = actions.cycle_history_next,
						["<C-Up>"] = actions.cycle_history_prev,
						["<C-f>"] = actions.preview_scrolling_down,
						["<C-b>"] = actions.preview_scrolling_up,
						["<ESC>"] = actions.close,
					},
					n = {
						["q"] = actions.close,
						["<ESC>"] = actions.close,
					},
				},
			},
		}
	end,
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		-- Here we define the Telescope extension for all plugins.
		-- If you delete a plugin, you can also delete its Telescope extension.
		telescope.load_extension("notify")
	end,
}
