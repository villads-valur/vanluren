local g = vim.g

-- map the leader key
-- Leader is Space as always
vim.g.mapleader = " " -- 'vim.g' sets global variables

-- Writing
map("n", "<Leader>w", ":w<CR>")
map("n", "<Leader>q", ":q<CR>")
map("i", "jj", "<ESC>")
map({ "n", "v" }, "x", '"_x') -- don't yank text on cut ( x )

-- Search
map("n", "<ESC><ESC>", ":nohlsearch<CR>")

-- Buffers
map("n", "<Leader>x", ":bd<CR>")

-- Windows
map("n", "<Leader>v", ":vnew<CR>")
map("n", "<Leader><Down>", "<C-W><C-J>")
map("n", "<Leader><Up>", "<C-W><C-K>")
map("n", "<Leader><Right>", ":vnew<CR>")
map("n", "<Leader><Left>", "<C-W><C-H>")
