local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

return {
	"nvim-telescope/telescope.nvim",
	init = function()
		map("n", "<Leader>t", "<CMD>Telescope find_files<CR>", opts)
		map("n", "<Leader>fw", "<CMD>Telescope live_grep<CR>", opts)
		map("n", "<Leader>fb", "<CMD>Telescope find_buffers<CR>", opts)
	end,
	opts = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local previewers = require("telescope.previewers")
		return {
			defaults = {
				mappings = {
					i = {
						["<ESC>"] = actions.close,
					},
				},
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				prompt_prefix = " ? ",
				selection_caret = " › ",
				entry_prefix = "  ",
				initial_mode = "insert",
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				file_sorter = require("telescope.sorters").get_fuzzy_file,
				file_ignore_patterns = { "node_modules" },
				generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
				path_display = { "truncate" },
				winblend = 0,
				border = {},
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				color_devicons = true,
				use_less = true,
				set_env = { ["COLORTERM"] = "truecolor" },
				file_previewer = previewers.vim_buffer_cat.new,
				grep_previewer = previewers.vim_buffer_vimgrep.new,
				qflist_previewer = previewers.vim_buffer_qflist.new,
				buffer_previewer_maker = previewers.buffer_previewer_maker,
			},
		}
	end,
}
