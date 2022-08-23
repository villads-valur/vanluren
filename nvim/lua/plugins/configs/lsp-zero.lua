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

local function custom_on_attach(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
end

lsp.preset("recommended")
lsp.nvim_workspace()

require("luasnip.loaders.from_vscode").lazy_load()

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
	on_attach = custom_on_attach,
	commands = {
		OrganizeImports = {
			organize_imports,
			description = "Organize Imports",
		},
	},
})

lsp.configure("jsonls", {
	on_attach = custom_on_attach,
})

lsp.configure("sumneko_lua", {
	on_attach = custom_on_attach,
})

lsp.configure("prismals", {
	on_attach = custom_on_attach,
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
