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

local function custom_on_attach(client)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
end

lsp.preset("recommended")
lsp.nvim_workspace()

lsp.ensure_installed({
	"html",
	"sumneko_lua",
	"tsserver",
	"tailwindcss",
	"tsserver",
})

lsp.on_attach(custom_on_attach)

lsp.configure("tsserver", {
	flags = {
		debounce_text_changes = 200,
	},
	commands = {
		OrganizeImports = {
			organize_imports,
			description = "Organize Imports",
		},
	},
})

lsp.configure("stylelint_lsp", {
	filetypes = { "css", "less", "scss" },
})

lsp.set_preferences({
	sign_icons = {
		error = "✘",
		warn = "▲",
		hint = "",
		info = "",
	},
})

lsp.setup()

vim.diagnostic.config({
	virtual_text = false,
	update_in_insert = true,
	signs = true,
	underline = true,
})

-- Map to easier commands
cmd("command! LspDef lua vim.lsp.buf.definition()")
cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
cmd("command! LspHover lua vim.lsp.buf.hover()")
cmd("command! LspRename lua vim.lsp.buf.rename()")
cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
cmd("command! LspDiagLine lua vim.diagnostic.show_line_diagnostics()")
cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

map("n", "lp", ":LspDiagPrev<CR>")
map("n", "ln", ":LspDiagNext<CR>")

map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "gf", "<cmd>lua vim.lsp.buf.declaration()<CR>")
map("n", "gs", "<cmd>LspSignatureHelp<CR>")

map("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("v", "<Leader>ca", ":<C-U>lua vim.lsp.buf.range_code_action()<CR>")
map("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")

-- Keybindings
