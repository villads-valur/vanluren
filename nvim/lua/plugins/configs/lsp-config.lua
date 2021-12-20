local map = require("utils").map
local cmd = vim.cmd
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		"documentation",
		"detail",
		"additionalTextEdits",
	},
}

local function on_attach(client, bufnr)
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- Map to easier commands
	cmd("command! LspDef lua vim.lsp.buf.definition()")
	cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
	cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
	cmd("command! LspHover lua vim.lsp.buf.hover()")
	cmd("command! LspRename lua vim.lsp.buf.rename()")
	cmd("command! LspRefs lua vim.lsp.buf.references()")
	cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
	cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
	cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
	cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
	cmd("command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
	cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	map("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	map("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	map("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	map("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	map("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	map("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	map("n", "<space>ca", ":CodeActionMenu<CR>", opts) -- this is provided by the code action menu plugin
	map("v", "<space>ca", ":CodeActionMenu<CR>", opts) -- this is provided by the code action menu plugin
	map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	map("n", "ge", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	map("n", "lp", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	map("n", "ln", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	map("n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	if client.name == "tsserver" then
		opts.capabilities.document_formatting = false
	end
end

require("nvim-lsp-installer").on_server_ready(function(server)
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
		settings = {},
	}

	if opts.capabilities.document_highlight then
		cmd("autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()")
		cmd("autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()")
		cmd("autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()")
	end

	server:setup(opts)
	cmd([[ do User LspAttachBuffers ]])
end)

require("plugins.configs.lsp-handlers")
