local map = vim.api.nvim_set_keymap

require("nvim-tree").setup(
  {
    hijack_ntrw = false
  }
)

map("n", "<leader>n", ":NvimTreeToggle<CR>", options)
map("n", "<leader>rt", ":NvimTreeRefresh<CR>", options)
