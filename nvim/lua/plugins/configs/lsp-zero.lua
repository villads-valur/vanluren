local lsp = require("lsp-zero")
local map = require("utils").map
local cmd = vim.cmd

local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end

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
		client.resolved_capabilities.document_range_formatting = false
	end,
	commands = {
		OrganizeImports = {
			organize_imports,
			description = "Organize Imports",
		},
	},
})

lsp.configure("jsonls", {
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
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

map("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("v", "<Leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>")
map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "<Leader>rn", "<cmd>lua vim.buf.rename()<CR>")
map("n", "lp", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "ln", "<cmd>lua vim.diagnostic.goto_next()<CR>")
