-- maps.lua

local map = vim.api.nvim_set_keymap

-- map the leader key
-- Leader is Space
map('n', '<Space>', '', {})
vim.g.mapleader = ' '  -- 'vim.g' sets global variables


options = { noremap = true }

-- Writing
map('n', '<leader>w', ':w<CR>',options)

-- Search 
map('n', '<leader><esc>', ':nohlsearch<CR>', options)

-- Buffers
map('n', '<Tab>', ':bnext<CR>', options)
map('n', '<S-Tab>', ':bprev<CR>', options)

-- Splits
map('n', '<leader>v', ':vnew<CR>', options)

-- Fast Reload
map('n', '<leader>r', ':source ~/.config/nvim/init.lua<CR>', options)


