local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

return {
  "nvim-telescope/telescope.nvim",
  config = function()
    map("n", "<Leader>t", "<CMD>Telescope find_files<CR>", opts)
    map("n", "<Leader>fw", "<CMD>Telescope live_grep<CR>", opts)
    map("n", "<Leader>fb", "<CMD>Telescope find_buffers<CR>", opts)
  end
}
