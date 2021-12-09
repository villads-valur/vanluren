local map = vim.api.nvim_set_keymap
options = { noremap = true }

map("n","<leader>t", ":Telescope find_files<CR>", options)
map("n","<leader>f", ":Telescope live_grep<CR>", options)
