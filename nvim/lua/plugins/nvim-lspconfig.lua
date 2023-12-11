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
  opts = {
    -- Good for debugging
    format_notify = false,
    servers = {
      lua_ls = {},
      solargraph = {
        "ruby",
        "rakefile",
        settings = {
          solargraph = {
            autoformat = true,
            completion = true,
            diagnostic = true,
            folding = true,
            references = true,
            rename = true,
            symbols = true,
          },
        },
      },
      -- tsserver = {
      --   filetypes = { "javascriptreact", "typescriptreact", "json" },
      -- },
      volar = {
        tsdk = vim.fn.expand("$HOME/.config/yarn/global/node_modules/typescript"),
        filetypes = { "vue", "javascript", "typescript" },
      },
      stylelint_lsp = {
        filetypes = { "css", "scss", "less", "vue", "html" },
      },
      eslint = {
        settings = {
          workingDirectory = { mode = "auto" },
        },
      },
    },
    setup = {
      volar = function()
        require("lazyvim.util").lsp.on_attach(function(client)
          if client.name == "volar" then
            client.server_capabilities.documentFormattingProvider = false
          elseif client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          elseif client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          end
        end)
      end,
    },
  },
}
