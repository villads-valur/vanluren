return {
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)
		end,
	},
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
		},
	},
}
