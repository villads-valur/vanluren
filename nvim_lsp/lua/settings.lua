-- General Nvim Settings


local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- global options
o.swapfile = false
o.dir = '/tmp'
o.smartcase = true
o.laststatus = 2
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.scrolloff = 12
o.clipboard = "unnamedplus"
o.syntax = "enable"
o.number = true
o.mouse = "a"
o.splitbelow = true
o.splitright = true
o.termguicolors = true
o.undofile = true
o.updatetime = 300
o.scrolloff = 4
o.sidescrolloff = 2
o.cursorline = true
o.number = true
o.signcolumn = "yes"
o.timeoutlen = 500
o.statusline = [[%f %y %m %= %p%% %l:%c]]
