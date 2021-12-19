local null_ls = require("null-ls")
local b = null_ls.builtins
local cmd = vim.cmd

local sources = {
	b.formatting.prettierd,
	b.formatting.stylua,
	b.formatting.eslint_d,
	b.code_actions.eslint_d,
	b.completion.spell,
}

null_ls.setup({
	debug = false,
	sources = sources,
	on_attach = function(client)
		-- format on save
		if client.resolved_capabilities.document_formatting then
			cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()")
		end
		-- Add a format command
		cmd("command! Format lua vim.lsp.buf.formatting()")
	end,
})
