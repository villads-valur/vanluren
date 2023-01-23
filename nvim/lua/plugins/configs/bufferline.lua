local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

return {
  "akinsho/bufferline.nvim",
  config = function()
require("bufferline").setup({})
map("n", "<Tab>", "<CMD>BufferLineCycleNext<CR>", opts )
map("n", "<S-Tab>", "<CMD>BufferLineCyclePrev<CR>", opts )
  end
}

