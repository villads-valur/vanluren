return {
  {
    "mason-org/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      -- Patch registry.refresh to handle nil updated_registries
      local registry = require("mason-registry")
      local original_refresh = registry.refresh

      registry.refresh = function(callback)
        return original_refresh(function(success, updated_registries)
          -- Ensure updated_registries is never nil
          callback(success, updated_registries or {})
        end)
      end

      require("mason-lspconfig").setup({
        ensure_installed = {},
        automatic_installation = false,
        automatic_enable = false,
      })
    end,
  },
}
