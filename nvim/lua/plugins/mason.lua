return {
 -- mason-lspconfig [auto start lsp]
  -- https://github.com/williamboman/mason-lspconfig.nvim
  -- This plugin auto starts the lsp servers installed by Mason
  -- every time Neovim trigger the event FileType.
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    event = "User BaseFile",
    opts = function(_, opts)
      if not opts.handlers then opts.handlers = {} end
      opts.handlers[1] = function(server) utils_lsp.setup(server) end
    end,
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
      utils_lsp.apply_default_lsp_settings() -- Apply our default lsp settings.
      utils.trigger_event("FileType")        -- This line starts this plugin.
    end,
  },

  --  mason [lsp package manager]
  --  https://github.com/williamboman/mason.nvim
  --  https://github.com/zeioth/mason-extra-cmds
  {
    "williamboman/mason.nvim",
    dependencies = { "zeioth/mason-extra-cmds", opts = {} },
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
      "MasonUpdate",
      "MasonUpdateAll", -- this cmd is provided by mason-extra-cmds
    },
    opts = {
      registries = {
        "github:nvim-java/mason-registry",
        "github:mason-org/mason-registry",
      },
      ui = {
        icons = {
          package_installed = "✓",
          package_uninstalled = "✗",
          package_pending = "⟳",
        },
      },
    }
  }
}
