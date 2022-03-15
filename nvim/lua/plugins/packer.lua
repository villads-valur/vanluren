-- Plugin manager configuration file
local cmd = vim.cmd
cmd([[packadd packer.nvim]])

local packer = require("packer")
local use = packer.use

local config = function(name)
	return string.format("require('plugins.%s')", name)
end

return packer.startup(function()
	use("lewis6991/impatient.nvim")

	-- packer can manage itself
	use({
		"wbthomason/packer.nvim",
		event = "VimEnter",
	})

	use("nvim-lua/plenary.nvim")

	-- tpope essentials
	use("tpope/vim-surround")

	-- icons
	use("kyazdani42/nvim-web-devicons")

	-- dashboard
	use({
		"goolord/alpha-nvim",
		after = "nvim-web-devicons",
		config = config("alpha"),
	})

	--- colorschemes
	use({
		"Shatur/neovim-ayu",
		config = config("ayu"),
	})

	use("navarasu/onedark.nvim")

	--- statusline
	use({
		"feline-nvim/feline.nvim",
		after = "nvim-web-devicons",
		config = config("feline"),
	})

	--- tree view
	use({
		"kyazdani42/nvim-tree.lua",
		after = "nvim-web-devicons", -- optional, for file icon
		config = config("nvim-tree"),
	})

	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		config = config("telescope"),
	})

	use({
		"weilbith/nvim-code-action-menu",
		config = config("code-action-menu"),
		cmd = "CodeActionMenu",
		after = "telescope",
	})

	-- LSP stuff
	use("neovim/nvim-lspconfig")

	use("williamboman/nvim-lsp-installer")

	use({ "RishabhRD/nvim-lsputils", requires = { "RishabhRD/popfix" } })

	use({
		"nvim-treesitter/nvim-treesitter",
		event = "BufRead",
		config = config("treesitter"),
	})
	-- formatting
	use("jose-elias-alvarez/null-ls.nvim")

	-- autopairs
	use({ "windwp/nvim-autopairs", config = config("autopairs") })

	-- better escape
	use({ "max397574/better-escape.nvim" })

	use({ "lukas-reineke/indent-blankline.nvim", config = config("indentline") })

	-- bufferline
	use({ "akinsho/bufferline.nvim", after = "nvim-web-devicons", config = config("bufferline") })

	-- gitsigns
	use({ "lewis6991/gitsigns.nvim" })

	-- JSX
	use("maxmellon/vim-jsx-pretty")

	-- Annotations
	use({
		"danymat/neogen",
		config = function()
			require("neogen").setup({})
		end,
		requires = "nvim-treesitter/nvim-treesitter",
		-- Uncomment next line if you want to follow only stable versions
		-- tag = "*"
	})

	-- snippets
	use({
		"rafamadriz/friendly-snippets",
		event = "InsertEnter",
	})

	use({
		"hrsh7th/nvim-cmp",
		config = config("cmp"),
	})

	use({
		"L3MON4D3/LuaSnip",
		wants = "friendly-snippets",
		after = "nvim-cmp",
	})

	use({
		"saadparwaiz1/cmp_luasnip",
		after = "LuaSnip",
	})

	use({
		"hrsh7th/cmp-nvim-lsp",
		after = "cmp-nvim-lua",
	})

	use({
		"hrsh7th/cmp-nvim-lua",
	})

	use({
		"hrsh7th/cmp-buffer",
		after = "cmp-nvim-lsp",
	})

	use({
		"hrsh7th/cmp-path",
		after = "cmp-buffer",
	})
end)
