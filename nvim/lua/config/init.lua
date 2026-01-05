-----------------------------------------------------------
-- Neovim settings
-----------------------------------------------------------
local g = vim.g
local opt = vim.opt
local wo = vim.wo

-- General
opt.shortmess:append("sI")
opt.copyindent = true
opt.fillchars = { eob = " " } -- Disable `~` on nonexistent lines
opt.mouse = "a" -- enable mouse support
opt.pumheight = 10 -- enable mouse support
opt.clipboard = "unnamedplus" -- copy/paste to system clipboard
-- swapfile disabled in options.lua
opt.updatetime = 100 -- Length of time to wait before triggering the plugin
opt.timeoutlen = 200 -- Length of time to wait for a mapped sequence
opt.preserveindent = true
opt.showmatch = true -- highlight matching parenthesis
opt.foldmethod = "marker" -- enable folding (default 'foldmarker')
opt.splitright = true -- vertical split to the right
opt.splitbelow = true -- orizontal split to the bottom
opt.ignorecase = true -- ignore case letters when search
opt.smartcase = true -- ignore lowercase for the whole pattern
opt.linebreak = true -- wrap on word boundary
opt.encoding = "utf-8" -- Set encoding to  UTF-8
opt.cursorline = true -- Highlight the current line
opt.laststatus = 3 -- joined status bar
opt.wildignore = "*node_modules/**" -- Don't search inside Node.js modules
opt.showmode = false -- Hide status
opt.emoji = false --- Fix emoji display
opt.completeopt = "menuone,noselect"
-- Memory, CPU
opt.hidden = true -- enable background buffers
opt.history = 100 -- remember n lines in history
opt.undofile = true
opt.lazyredraw = false -- faster scrolling
-- Colorscheme
opt.termguicolors = true -- enable 24-bit RGB colors
-- Tabs, indent
opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 2 -- shift 2 spaces when tab
opt.tabstop = 2 -- 1 tab == 2 spaces
opt.smartindent = true -- autoindent new lines

wo.signcolumn = "yes:2" --  Always show the sign colum
wo.cursorline = true -- Highlight the current line
wo.number = true -- show line number

vim.cmd([[
  let g:loaded_perl_provider = 0
  let g:loaded_ruby_provider = 0
]])
-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 700 })
  end,
})

-- don't auto commenting new lines
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Startup
-- disable builtins plugins
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit",
  "black",
  "matchparen",
  "tohtml",
  "tutor",
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end
