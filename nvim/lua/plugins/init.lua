-- Plugin manager configuration file
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

local packer = require("packer")
local use = packer.use

local config = function(name)
	return string.format("require('plugins.configs.%s')", name)
end

return require("packer").startup(function()
	-- Packer can manage itself
	use({ "wbthomason/packer.nvim" })

	-- Colorschemes
	use({ "navarasu/onedark.nvim" })
	use({ "LunarVim/onedarker.nvim" })
	use({ "tiagovla/tokyodark.nvim" })
	use({ "Shatur/neovim-ayu" })
	use({ "cormacrelf/dark-notify", config = config("dark-notify") })

	-- Dashboard
	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = config("alpha"),
	})

	-- Statusline
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = config("lualine"),
		cond = function()
			return not vim.g.vscode
		end,
	})

	-- Modes
	use({
		"mvllow/modes.nvim",
		config = function()
			vim.opt.cursorline = true
			require("modes").setup()
		end,
		cond = function()
			return not vim.g.vscode
		end,
	})

	-- Filetree
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
		config = config("nvim-tree"),
		cond = function()
			return not vim.g.vscode
		end,
	})

	-- Monitor startup time
	use({ "lewis6991/impatient.nvim" })

	-- Boost startup time
	use({
		"nathom/filetype.nvim",
		config = function()
			vim.g.did_load_filetypes = 1
		end,
	})

	-- Tpope essentials
	use("tpope/vim-surround")
	use("tpope/vim-commentary")
	use("tpope/vim-fugitive")

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = config("telescope"),
	})

	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		after = "telescope.nvim",
		run = "make",
		config = function()
			require("telescope").load_extension("fzf")
		end,
	})

	-- Bufferline
	use({ "akinsho/bufferline.nvim", after = "nvim-web-devicons", config = config("bufferline") })

	-- Buffkill
	use({ "qpkorr/vim-bufkill", config = config("buffkill") })

	-- Buffkill
	use("moll/vim-bbye")

	-- Better escape
	use({ "max397574/better-escape.nvim", event = "InsertCharPre" })

	-- Autopairs
	use({ "windwp/nvim-autopairs", config = config("autopairs"), event = "InsertEnter" })

	-- Auto close tags
	use({
		"windwp/nvim-ts-autotag",
		config = config("autotag"),
		event = "InsertEnter",
	})

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

	--Documentation generator
	use({
		"danymat/neogen",
		config = config("neogen"),
		requires = "nvim-treesitter/nvim-treesitter",
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
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
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

	-- LSP saga
	use({
		"kkharji/lspsaga.nvim",
		event = "BufRead",
		after = "nvim-lspconfig",
		config = config("lsp-saga"),
	})

	--MDX Syntax highlighting
	use({
		"findango/vim-mdx",
	})

	-- Markdown preview
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && yarn install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})

	-- Easy motion
	use({
		"phaazon/hop.nvim",
		event = "BufRead",
		config = config("hop"),
	})
	-- Automatically set up your configuration after cloning packer.nvim
	if packer_bootstrap then
		require("packer").sync()
	end
end)
