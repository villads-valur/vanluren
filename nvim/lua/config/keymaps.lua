-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyLazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local keymap = vim.keymap.set
local silent = { silent = true }

-- General
keymap("n", "<Leader>w", "<cmd>w<cr>", silent)
keymap("n", "<Leader>v", "<cmd>vsplit<cr>", silent)
keymap("n", "<Leader>q", "<cmd>q<cr>", silent)

---- Remove highlights
keymap("n", "<CR>", ":noh<CR><CR>", silent)
keymap("n", "<ESC><ESC>", ":noh<CR><CR>", silent)

---- Don't yank on delete char
keymap("n", "x", '"_x', silent)
keymap("n", "X", '"_X', silent)
keymap("v", "x", '"_x', silent)
keymap("v", "X", '"_X', silent)

-- Don't yank on visual paste
keymap("v", "p", '"_dP', silent)

-- Buffers
keymap("n", "<Tab>", "<cmd>bnext<CR>", silent)
keymap("n", "<S-Tab>", "<cmd>bprevious<CR>", silent)
keymap("n", "<leader>x", "<cmd>bd<cr>", silent)
keymap("n", "<leader>x", "<cmd>bd<cr>", silent)
keymap("n", "<leader>cn", "<cmd>:set rnu!<cr>", silent)
