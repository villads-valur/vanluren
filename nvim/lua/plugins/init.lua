-- Plugin manager configuration file
local cmd = vim.cmd
cmd([[packadd packer.nvim]])

local packer = require("packer")
local use = packer.use

local config = function(name)
	return string.format("require('plugins.configs.%s')", name)
end

return require("packer").startup(function()
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Colorschemes
	use({ "navarasu/onedark.nvim" })
	use({ "Shatur/neovim-ayu" })

	-- Dashboard
	use({
		"goolord/alpha-nvim",
		after = "nvim-web-devicons",
		config = config("alpha"),
	})

	--- statusline
	use({
		"feline-nvim/feline.nvim",
		after = "nvim-web-devicons",
		config = config("feline"),
	})

	-- Modes
	use({
		"mvllow/modes.nvim",
		config = function()
			vim.opt.cursorline = true
			require("modes").setup()
		end,
	})

	-- Filetree
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
		config = config("nvim-tree"),
	})

	-- Monitor startup time
	use("lewis6991/impatient.nvim")

	-- Tpope essentials
	use("tpope/vim-surround")

	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = config("telescope"),
	})

	-- bufferline
	use({ "akinsho/bufferline.nvim", after = "nvim-web-devicons", config = config("bufferline") })

	-- better escape
	use("max397574/better-escape.nvim")

	use({ "lukas-reineke/indent-blankline.nvim", config = config("indentline") })

	-- Formatting
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = "PlatyPew/format-installer.nvim",
		after = "nvim-lspconfig", -- To prevent null-ls from failing to read buffer
		config = config("null-ls"),
	})
	-- LSP stuff
	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/nvim-lsp-installer" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
		config = config("lsp-zero"),
	})
end)
