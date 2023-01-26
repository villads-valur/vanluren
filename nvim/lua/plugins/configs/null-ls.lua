return {
	"jose-elias-alvarez/null-ls.nvim",
	event = "BufReadPre",
	dependencies = { "mason.nvim" },
	opts = function()
		local nls = require("null-ls")
		local builtins = nls.builtins
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		return {
			sources = {
				-- builtins.formatting.prettierd,
				builtins.formatting.prismaFmt,
				builtins.formatting.stylua,
				builtins.completion.spell.with({
					filetypes = { "markdown" },
				}),
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end,
		}
	end,
}
