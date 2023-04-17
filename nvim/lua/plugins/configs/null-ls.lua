return {
	"jose-elias-alvarez/null-ls.nvim",
	event = "BufReadPre",
	dependencies = { "mason.nvim" },
	config = function()
		local null_ls = require("null-ls")

		local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
		local event = "BufWritePre"
		local async = event == "BufWritePost"

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.formatting.yamlfmt,
				null_ls.builtins.formatting.prismaFmt,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.completion.spell.with({
					filetypes = { "markdown" },
				}),
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.keymap.set("n", "<Leader>f", function()
						vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
					end, { buffer = bufnr, desc = "[LSP] format" })

					vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })

					vim.api.nvim_create_autocmd(event, {
						buffer = bufnr,
						group = group,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr, async = async })
						end,
						desc = "[LSP] format on save",
					})
				end

				if client.supports_method("textDocument/rangeFormatting") then
					vim.keymap.set("x", "<Leader>f", function()
						vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
					end, { buffer = bufnr, desc = "[LSP] format" })
				end
			end,
		})
	end,
}
