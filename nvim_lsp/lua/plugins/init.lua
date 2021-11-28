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
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} },
        config = config("telescope")
    }

    -- Misc
    use("nvim-lua/plenary.nvim")
    use_with_config("nathom/filetype.nvim", "filetype") -- greatly reduces startup time

end)
