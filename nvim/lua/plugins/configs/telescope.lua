local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

return {
	"nvim-telescope/telescope.nvim",
	config = function()
		require("telescope").setup({
			-- see :help telescope.setup()
			defaults = {
				mappings = {
					i = {
						["<Esc>"] = require("telescope.actions").close,
					},
				},
				-- The below pattern is lua regex and not wildcard
				file_ignore_patterns = { "node_modules", "%.out" },
				prompt_prefix = "🔍 ",
			},
		})
		map("n", "<Leader>t", "<CMD>Telescope find_files<CR>", opts)
		map("n", "<Leader>fw", "<CMD>Telescope live_grep<CR>", opts)
		map("n", "<Leader>fb", "<CMD>Telescope find_buffers<CR>", opts)
	end,
}
