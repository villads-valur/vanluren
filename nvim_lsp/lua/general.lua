local u = require("utils")

vim.g.mapleader = " "

vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noinsert" }
vim.opt.expandtab = true
vim.opt.foldlevelstart = 99
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.mouse = "a"
vim.opt.pumheight = 10
vim.opt.shiftwidth = 4
vim.opt.shortmess:append("cA")
vim.opt.showcmd = false
vim.opt.showtabline = 2
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.statusline = [[%f %y %m %= %p%% %l:%c]]
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.directory = "/tmp"
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 2

vim.opt.cursorline = true
vim.opt.number = true
vim.opt.signcolumn = "yes"

_G.global = {}

-- terminal
_G.global.terminal = {
    on_open = function()
        vim.cmd("startinsert")
        vim.cmd("setlocal nonumber norelativenumber")
    end,

    -- suppress exit code message
    on_close = function()
        if not string.match(vim.fn.expand("<afile>"), "nnn") then
            vim.api.nvim_input("<CR>")
        end
    end,
}
