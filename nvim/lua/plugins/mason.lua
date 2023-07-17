return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      "prettierd",
      "vue-language-server",
      "solargraph",
    })
  end,
}
