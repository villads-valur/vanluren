return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "gh", "<cmd>lua vim.lsp.buf.hover()<cr>" }
    keys[#keys + 1] = { "ln", "<cmd>lua vim.diagnostic.goto_next({severity=vim.diagnostic.severity['ERROR']})<cr>" }
    keys[#keys + 1] = { "lp", "<cmd>lua vim.diagnostic.goto_prev({severity=vim.diagnostic.severity['ERROR']})<cr>" }
    keys[#keys + 1] = { "Ln", "<cmd>lua vim.diagnostic.goto_prev()<cr>" }
    keys[#keys + 1] = { "Lp", "<cmd>lua vim.diagnostic.goto_prev()<cr>" }
  end,
}
