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
    opts = function(_, opts)
      -- Patch registry.refresh to handle nil updated_registries
      local registry = require("mason-registry")
      if not registry._refresh_patch_applied then
        local original_refresh = registry.refresh

        registry.refresh = function(callback)
          return original_refresh(function(success, updated_registries)
            if callback then
              callback(success, updated_registries or {})
            end
          end)
        end

        registry._refresh_patch_applied = true
      end
      return opts
    end,
  },
}
