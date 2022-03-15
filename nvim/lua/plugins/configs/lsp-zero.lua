local lsp = require("lsp-zero")
local map = require("utils").map
local cmd = vim.cmd

lsp.preset("recommended")
lsp.nvim_workspace()

lsp.ensure_installed({
	"html",
	"sumneko_lua",
	"tsserver",
	"dockerls",
	"tailwindcss",
})

lsp.configure("tsserver", {
	flags = {
		debounce_text_changes = 200,
	},
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
	end,
})

lsp.setup()

-- Map to easier commands
cmd("command! LspDef lua vim.buf.definition()")
cmd("command! LspFormatting lua vim.buf.formatting()")
cmd("command! LspHover lua vim.buf.hover()")
cmd("command! LspRename lua vim.buf.rename()")
cmd("command! LspTypeDef lua vim.buf.type_definition()")
cmd("command! LspImplementation lua vim.buf.implementation()")
cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
cmd("command! LspDiagLine lua vim.diagnostic.show_line_diagnostics()")
cmd("command! LspSignatureHelp lua vim.buf.signature_help()")

map("n", "gh", "<cmd>lua vim.buf.hover()<CR>")
map("n", "<Leader>rn", "<cmd>lua vim.buf.rename()<CR>")
map("n", "lp", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "ln", "<cmd>lua vim.diagnostic.goto_next()<CR>")
