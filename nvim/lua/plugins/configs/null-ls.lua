local null_ls = require("null-ls")
local builtins = null_ls.builtins
local formatter_install = require("format-installer")

null_ls.setup({
	debug = false,
	sources = {
		builtins.formatting.prettierd,
		builtins.formatting.prismaFmt,
		builtins.formatting.stylua,
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
