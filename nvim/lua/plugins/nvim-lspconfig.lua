return {
  "neovim/nvim-lspconfig",
  keys = {
    { "gh", vim.lsp.buf.hover, desc = "Hover Documentation" },
    {
      "ln",
      function()
        vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
      end,
      desc = "Next Error",
    },
    {
      "lp",
      function()
        vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end,
      desc = "Previous Error",
    },
    {
      "Ln",
      function()
        vim.diagnostic.goto_next()
      end,
      desc = "Next Diagnostic",
    },
    {
      "Lp",
      function()
        vim.diagnostic.goto_prev()
      end,
      desc = "Previous Diagnostic",
    },
  },
}
