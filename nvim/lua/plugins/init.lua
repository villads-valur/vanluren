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

	-- Statusline
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = config("lualine"),
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
	use("tpope/vim-commentary")

	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = config("telescope"),
	})

	-- Bufferline
	use({ "akinsho/bufferline.nvim", after = "nvim-web-devicons", config = config("bufferline") })

	-- Better escape
	use({ "max397574/better-escape.nvim", event = "InsertCharPre" })

	-- Indentline
	use({ "lukas-reineke/indent-blankline.nvim", config = config("indentline"), event = "BufRead" })

	-- Gitsigns
	use({ "lewis6991/gitsigns.nvim", requires = {
		"nvim-lua/plenary.nvim",
	}, config = config("gitsigns") })

	-- TreeSitter
	use({
		"nvim-treesitter/nvim-treesitter",
		event = { "BufRead", "BufNewFile" },
		config = config("treesitter"),
		run = ":TSUpdate",
	})

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
			{ "rafamadriz/friendly-snippets", event = "InsertEnter" },
		},
		config = config("lsp-zero"),
	})
end)
