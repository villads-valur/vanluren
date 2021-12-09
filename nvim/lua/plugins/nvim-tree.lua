local map = vim.api.nvim_set_keymap

require("nvim-tree").setup()

map("n", "<leader>n", ":NvimTreeToggle<CR>", options)
map("n", "<leader>rt", ":NvimTreeRefresh<CR>", options)
