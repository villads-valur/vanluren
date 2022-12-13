local null_ls = require("null-ls")
local builtins = null_ls.builtins

null_ls.setup({
	debug = false,
	sources = {
		builtins.formatting.prettierd,
		builtins.formatting.prismaFmt,
		builtins.formatting.stylua,
		builtins.diagnostics.vale,
		builtins.completion.spell.with({
			filetypes = { "markdown" },
		}),
	},
	on_attach = function(client)
		if client.server_capabilities.documentFormattingProvider then
			vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
		end
	end,
})
