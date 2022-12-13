require("neogen").setup({
	snippet_engine = "luasnip",
})

local map = require("utils").map

map("n", "<Leader>d", ":lua require('neogen').generate()<CR>")
