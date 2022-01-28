-- Keymaps configuration file: keymaps of neovim
-- and plugins.

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Basic
-- use space as a the leader key
vim.g.mapleader = ' '

-- Writing
map('n', '<leader>w', ':w<CR>', opts)
map('i', '<leader>w', '<C-c>:w<CR>', opts)

-- Window
map('n', '<leader>q', ':q<CR>', opts)

map('n', '<leader>v', ':vsplit<CR>', opts)
map('n', '<leader>h', ':hsplit<CR>', opts)


-- open terminal
map('n', '<C-t>', ':Term<CR>', { noremap = true })

