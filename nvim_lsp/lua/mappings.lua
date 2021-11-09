-- maps.lua
local map = vim.api.nvim_set_keymap
local g = vim.g

-- map the leader key
map('n', '<Space>', '', {})
g.mapleader = ' '  -- 'vim.g' sets global variables


options = { noremap = true }

map('n', '<leader><esc>', ':nohlsearch<cr>', options)

-- Writing
map('n', '<Leader>w', ':w<cr>', options)

-- Splits
map('n', '<Leader>v', ':vsplit<cr>', options)

-- Buffers
--
map('n', '<Leader>q', ':bd<cr>', options)
map('n', '<Tab>', ':bnext<cr>', options)
map('n', '<S-Tab>', ':bprev<cr>', options)

-- Reload init
map('n', '<Leader>r', ':so $HOME/.config/nvim/init.lua<CR>', options)


