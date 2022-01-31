local map = require("utils").map

require("bufferline").setup({})

map("n", "<TAB>", ":BufferLineCycleNext<CR>")
map("n", "<S-TAB>", ":BufferLineCyclePrev<CR>")
