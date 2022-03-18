local null_ls = require("null-ls")
local builtins = null_ls.builtins
local formatter_install = require("format-installer")

null_ls.setup({
	debug = false,
	sources = {
		builtins.formatting.prettier_d_slim,
		builtins.formatting.prismaFmt,
		builtins.formatting.style_lua,
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
		end
	end,
})
