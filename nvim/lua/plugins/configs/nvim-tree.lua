require("nvim-tree").setup({})

local map = require("utils").map

map("n", "<Leader>n", ":NvimTreeToggle<CR>")
map("n", "<Leader>e", ":NvimTreeToggle<CR>")
map("n", "<Leader>fe", ":NvimTreeFindFile<CR>")
