-- Initialize Packer:
vim.cmd("packadd packer.nvim")

return require("packer").startup(function()    
    use({ "wbthomason/packer.nvim", opt = true })

    local config = function(name)
        return string.format("require('plugins.%s')", name)
    end

    local use_with_config = function(path, name)
        use({ path, config = config(name) })
    end

    -- Basics and TPope essentials
    use("tpope/vim-repeat")
    use("tpope/vim-surround")
    use("tpope/vim-unimpaired")

    use_with_config("numToStr/Comment.nvim", "comment") -- comment plugin
    use("tpope/vim-sleuth") -- detects indentation
    use({
        { "lewis6991/gitsigns.nvim", config = config("git") }, -- git plugins
        { "tpope/vim-fugitive", requires = "tpope/vim-rhubarb" },
    })
    
    -- additional functionality
    use("ggandor/lightspeed.nvim") -- motion
    use_with_config("ojroques/nvim-bufdel", "bufdel") -- better buffer deletion
    use_with_config("windwp/nvim-autopairs", "autopairs") -- autocomplete pairs

    -- UI
    use_with_config('ayu-theme/ayu-vim', "ayu")
    use_with_config("jose-elias-alvarez/buftabline.nvim", "buftabline") -- show buffers in tabline
    use {
	'kyazdani42/nvim-tree.lua',
	requires = {
	'kyazdani42/nvim-web-devicons', -- optional, for file icon
	},
	config = config("nvim-tree") 
    }

    -- Popup search
    use({
        "nvim-telescope/telescope.nvim", -- fuzzy finder
        config = config("telescope"),
        requires = {
            {
                "nvim-telescope/telescope-fzf-native.nvim", -- better algorithm
                run = "make",
            },
            {'nvim-lua/plenary.nvim'}
        },
    })

    -- CMP
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp' 
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'quangnguyen30192/cmp-nvim-ultisnips' 

    -- LSP stuff:
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"
    use "jose-elias-alvarez/null-ls.nvim"
    use "jose-elias-alvarez/nvim-lsp-ts-utils"
    use("b0o/schemastore.nvim") -- simple access to json-language-server schemae
    use_with_config("RRethy/vim-illuminate", "illuminate") -- highlights and allows moving between variable references
    use {'mattn/emmet-vim'}
    use {'SirVer/ultisnips', requires = {"honza/vim-snippets", "quangnguyen30192/cmp-nvim-ultisnips"}, config = "require('plugins.ultisnips')", after = 'nvim-cmp'}

    -- Prettier
    use_with_config('mhartington/formatter.nvim', "formatter")

    -- treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = config("treesitter"),
    })
    use({
        "RRethy/nvim-treesitter-textsubjects", -- adds smart text objects
        ft = { "lua", "typescript", "typescriptreact" },
    })
    use({ "windwp/nvim-ts-autotag", ft = { "typescript", "typescriptreact" } }) -- automatically close jsx tags
    use({ "JoosepAlviste/nvim-ts-context-commentstring", ft = { "typescript", "typescriptreact" } }) -- makes jsx comments actually work

    -- Misc
    use("nvim-lua/plenary.nvim")
    use_with_config("nathom/filetype.nvim", "filetype") -- greatly reduces startup time

end)
