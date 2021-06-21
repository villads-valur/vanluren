local lspconfig = require("lspconfig")
local u = require("utils")
local capabilities = vim.lsp.protocol.make_client_capabilities();

capabilities.textDocument.completion.completionItem.snippetSupport = true;

local M = {}

M.setup = function(on_attach)
    lspconfig.cssls.setup({
        cmd = cmd,
        on_attach = function(client, bufnr)

        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        end,
    })
end

return M
