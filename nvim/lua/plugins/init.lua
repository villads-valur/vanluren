-- Initialize Packer:
local packer = require("plugins.packer")

local use = packer.use

local config = function(name)
	return string.format("require('plugins.configs.%s')", name)
end

return packer.startup(function()
	use("nvim-lua/plenary.nvim")

	use({
		"wbthomason/packer.nvim",
		event = "VimEnter",
	})

	-- basics like icons, bufferline, dashboard
	use({
		"kyazdani42/nvim-web-devicons",
	})

	use({
		"famiu/feline.nvim",
		after = "nvim-web-devicons",
		config = config("statusline"),
	})

	use({
		"akinsho/bufferline.nvim",
		after = "nvim-web-devicons",
		config = config("bufferline"),
	})

	use({
		"goolord/alpha-nvim",
		config = config("dashboard"),
	})

	use({
		"nvim-telescope/telescope.nvim",
		module = "telescope",
		cmd = "Telescope",
		requires = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "make",
			},
		},
		config = config("telescope"),
	})

	use({ "kosayoda/nvim-lightbulb", config = config("lightbulb") })

	use({
		"kyazdani42/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		config = config("nvim-tree"),
	})

	use({ "tpope/vim-surround" })
	use({ "tpope/vim-commentary" })

	use({ "ggandor/lightspeed.nvim" })

	-- UI
	use({ "wojciechkepka/vim-github-dark", config = config("theme") })

	--tresitter
	use({
		"nvim-treesitter/nvim-treesitter",
		event = "BufRead",
		config = config("treesitter"),
		run = ":TSUpdate",
	})

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		opt = true,
		setup = function()
			require("utils").packer_lazy_load("nvim-lspconfig")
			-- reload the current file so lsp actually starts for it
			vim.defer_fn(function()
				vim.cmd('if &ft == "packer" | echo "" | else | silent! e %')
			end, 0)
		end,
		config = config("lsp-config"),
	})

	use({ "williamboman/nvim-lsp-installer" })

	use({ "jose-elias-alvarez/nvim-lsp-ts-utils", after = { "nvim-treesitter" } })

	use({ "RishabhRD/nvim-lsputils", requires = "RishabhRD/popfix" })

	-- Null Ls
	use({
		"jose-elias-alvarez/null-ls.nvim",
		after = "nvim-lspconfig",
		config = config("null-ls"),
	})

	use({
		"hrsh7th/nvim-cmp",
		after = "friendly-snippets",
		config = config("cmp"),
	})

	-- Editing sugar
	use({
		"L3MON4D3/LuaSnip",
		wants = "friendly-snippets",
		after = "nvim-cmp",
		config = config("luasnip"),
	})
	use({
		"rafamadriz/friendly-snippets",
		event = "InsertEnter",
	})

	use({
		"saadparwaiz1/cmp_luasnip",
		after = "LuaSnip",
	})

	use({
		"hrsh7th/cmp-nvim-lua",
		after = "cmp_luasnip",
	})

	use({
		"hrsh7th/cmp-nvim-lsp",
		after = "cmp-nvim-lua",
	})

	use({
		"hrsh7th/cmp-buffer",
		after = "cmp-nvim-lsp",
	})

	use({
		"hrsh7th/cmp-path",
		after = "cmp-buffer",
	})

	use({
		"windwp/nvim-autopairs",
		after = "nvim-cmp",
		config = config("autopairs"),
	})

	use({ "github/copilot.vim" })

	-- Misc
	use({
		"andymass/vim-matchup",
		opt = true,
		setup = function()
			require("utils").packer_lazy_load("vim-matchup")
		end,
	})

	use({
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = config("better-escape"),
	})

	use({ "mattn/emmet-vim" })

	use({ "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" })
end)
