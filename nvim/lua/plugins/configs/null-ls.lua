local null_ls = require("null-ls")
local formatter_install = require("format-installer")

local sources = {}
for _, formatter in ipairs(formatter_install.get_installed_formatters()) do
	local config = { command = formatter.cmd }
	table.insert(sources, null_ls.builtins.formatting[formatter.name].with(config))
end


null_ls.setup({
 	sources = sources,
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
