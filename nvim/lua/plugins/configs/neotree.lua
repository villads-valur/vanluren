local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

return {
	"nvim-neo-tree/neo-tree.nvim",
	init = function()
		map("n", "<Leader>n", "<CMD>NeoTreeFocusToggle<CR>", opts)
		map("n", "<Leader>fe", "<CMD>NeoTreeRevealToggle<CR>", opts)
	end,
}
