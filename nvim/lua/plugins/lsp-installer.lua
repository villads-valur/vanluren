local lsp_installer = require("nvim-lsp-installer.servers")
local map = require("utils").map
local cmd = vim.cmd

local servers = {
	"sumneko_lua",
	"tsserver",
	"prismals",
	"cssls",
}

local function on_attach(client, bufnr)
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

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

-- Loop through the servers listed above.
for _, server_name in pairs(servers) do
	local server_available, server = lsp_installer.get_server(server_name)
	if server_available then
		server:on_ready(function()
			local opts = {
				on_attach = on_attach,
			}

			if server.name == "tsserver" then
				opts.on_attach = function(client, bufnr)
					client.resolved_capabilities.document_formatting = false
				end
			end
			server:setup(opts)
		end)
		if not server:is_installed() then
			server:install()
		end
	end
end
