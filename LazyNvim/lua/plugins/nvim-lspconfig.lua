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
  opts = function(_, opts)
    local vue_typescript_plugin = require("mason-registry").get_package("vue-language-server"):get_install_path()
      .. "/node_modules/@vue/language-server"
      .. "/node_modules/@vue/typescript-plugin"

    opts.servers = vim.tbl_deep_extend("force", opts.servers, {
      volar = {},
      -- Volar 2.0 has discontinued their "take over mode" which in previous version provided support for typescript in vue files.
      -- The new approach to get typescript support involves using the typescript language server along side volar.
      tsserver = {
        init_options = {
          plugins = {
            -- Use typescript language server along with vue typescript plugin
            {
              name = "@vue/typescript-plugin",
              location = vue_typescript_plugin,
              languages = { "javascript", "typescript", "vue" },
            },
          },
        },
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
          "vue",
        },
      },
    })
  end,
}
