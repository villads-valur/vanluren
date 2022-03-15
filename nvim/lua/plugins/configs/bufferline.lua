local map = require("utils").map

require("bufferline").setup({
	diagnostics = "nvim_lsp",
	show_buffer_close_icons = false,
	show_close_icon = false,
	offsets = { { filetype = "NvimTree" } },
	always_show_bufferline = false,
})

map("n", "<TAB>", ":BufferLineCycleNext<CR>")
map("n", "<S-TAB>", ":BufferLineCyclePrev<CR>")
map("n", "<Leader>x", ":bdelete! <CR>")
