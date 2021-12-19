local map = require("utils").map
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
map("n", "<Leader>n", ":NvimTreeToggle<CR>")

-- Buffers
map("n", "<Tab>", ":bnext<CR>")
map("n", "<S-Tab>", ":bprev<CR>")
map("n", "<Leader>x", ":bd<CR>")

-- Splits
map("n", "<Leader>v", ":vnew<CR>")
map("n", "<Leader><Down>", "<C-W><C-J>")
map("n", "<Leader><Up>", "<C-W><C-K>")
map("n", "<Leader><Right>", ":vnew<CR>")
map("n", "<Leader><Left>", "<C-W><C-H>")

-- Nvim Tree
map("n", "<Leader>n", ":NvimTreeToggle<CR>")

-- Keybindings
map("n", "<Leader>t", ":Telescope find_files<CR>")
map("n", "<Leader>b", ":Telescope live_grep<CR>")
map("n", "<Leader>sf", ":Telescope live_grep<CR>")
map("n", "<Leader>ca", "lua require'telescope.builtin.lsp_code_action'.planets{}")
