local o = vim.o

-- General settings
o.clipboard = 'unnamedplus'
o.syntax = "enable"
o.showmode = false -- modes
o.showcmd = false -- disable showcmd keys bottom right
o.hidden = false -- buffer hidden
o.cmdheight = 1 -- ex cmd height
o.mouse = "a" -- mouse on don't use mouse

-- Splits
o.splitbelow = true -- split behavior
o.splitright = true -- split behavior

-- UI
o.number = true
o.relativenumber = false
o.numberwidth = 2 -- width on number row
o.termguicolors = true -- colors tmux settings
o.signcolumn = "auto" -- 2 sign column
o.guifont = "Fira Code Regular Nerd Font Complete:h12" -- set font

-- Casing 
o.smartcase = true
o.hlsearch = true
o.incsearch = true
o.ignorecase = true

-- LSP
o.completeopt = "menu,menuone,noselect,noinsert" -- completion behaviour
o.omnifunc = "v:lua.vim.lsp.omnifunc" -- completion omnifunc
o.list = true
