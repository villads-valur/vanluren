local M = {}
local cmd = vim.cmd
local map = require("utils").map

function M.on_attach()
	vim.lsp.handlers["textDocument/codeAction"] = require("lsputil.codeAction").code_action_handler
	vim.lsp.handlers["textDocument/references"] = require("lsputil.locations").references_handler
	vim.lsp.handlers["textDocument/definition"] = require("lsputil.locations").definition_handler
	vim.lsp.handlers["textDocument/declaration"] = require("lsputil.locations").declaration_handler
	vim.lsp.handlers["textDocument/typeDefinition"] = require("lsputil.locations").typeDefinition_handler
	vim.lsp.handlers["textDocument/implementation"] = require("lsputil.locations").implementation_handler
	vim.lsp.handlers["textDocument/documentSymbol"] = require("lsputil.symbols").document_handler
	vim.lsp.handlers["workspace/sybol"] = require("lsputil.symbols").workspace_handler

	-- Map to easier commands
	cmd("command! LspDef lua vim.lsp.buf.definition()")
	cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
	cmd("command! LspHover lua vim.lsp.buf.hover()")
	cmd("command! LspRename lua vim.lsp.buf.rename()")
	cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
	cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
	cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
	cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
	cmd("command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
	cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

	map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>")
	map("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
	map("n", "lp", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
	map("n", "ln", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
end

return M
