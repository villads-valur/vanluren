-- Keymaps configuration file: keymaps of neovim
-- and plugins.

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Basic
-- use space as a the leader key
map("n", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Writing
map("n", "<Leader>w", ":w<CR>", opts)
map("i", "<Leader>w", "<C-c>:w<CR>", opts)

-- Window
map("n", "<Leader>q", ":q<CR>", opts)
map("n", "<Leader>v", ":vsplit<CR>", opts)
map("n", "<Leader>h", ":hsplit<CR>", opts)

-- Search
map("n", "<Esc><Esc>", ":noh<CR>", opts)

map("v", "p", '"_dP', opts)
