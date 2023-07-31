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
    servers = {
      volar = {},
      solargraph = {},
      tsserver = {},
      lua_ls = {},
      stylelint_lsp = {},
      eslint = {
        settings = {
          workingDirectory = { mode = "auto" },
        },
      },
    },
    setup = {
      eslint = function()
        require("lazyvim.util").on_attach(function(client)
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          end

          vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function(event)
              if not require("lazyvim.plugins.lsp.format").enabled() then
                -- exit early if autoformat is not enabled
                return
              end

              local client = vim.lsp.get_active_clients({ bufnr = event.buf, name = "eslint" })[1]
              if client then
                local diag = vim.diagnostic.get(event.buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
                if #diag > 0 then
                  vim.cmd("EslintFixAll")
                end
              end
            end,
          })
        end)
      end,
    },
  },
}
