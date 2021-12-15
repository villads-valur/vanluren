-- Initialize Packer:
vim.cmd("packadd packer.nvim")

return require("packer").startup(
  function()
    use({"wbthomason/packer.nvim", opt = true})

    local config = function(name)
      return string.format("require('plugins.%s')", name)
    end

    local use_with_config = function(path, name)
      use({path, config = config(name)})
    end

    -- Basics and TPope essentials
    use("tpope/vim-repeat")
    use("tpope/vim-surround")
    use("tpope/vim-unimpaired")

    use_with_config("numToStr/Comment.nvim", "comment") -- comment plugin
    use("tpope/vim-sleuth") -- detects indentation
    use(
      {
        {"lewis6991/gitsigns.nvim", config = config("git")}, -- git plugins
        {"tpope/vim-fugitive", requires = "tpope/vim-rhubarb"}
      }
    )

    -- additional functionality
    use("ggandor/lightspeed.nvim") -- motion
    use_with_config("ojroques/nvim-bufdel", "bufdel") -- better buffer deletion

    -- UI
    use_with_config("ayu-theme/ayu-vim", "ayu")
    use_with_config("jose-elias-alvarez/buftabline.nvim", "buftabline") -- show buffers in tabline

    use {
      "famiu/feline.nvim",
      after = "nvim-web-devicons",
      config = config("statusline")
    }

    use {
      "goolord/alpha-nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = config("dashboard")
    }
    use {
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons", -- optional, for file icon
      config = config("nvim-tree")
    }

    -- Popup search
    use(
      {
        "nvim-telescope/telescope.nvim", -- fuzzy finder
        config = config("telescope"),
        requires = {
          {
            "nvim-telescope/telescope-fzf-native.nvim", -- better algorithm
            run = "make"
          },
          {"nvim-lua/plenary.nvim"}
        }
      }
    )

    -- LSP Cmp
    use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      config = config("completion")
    }
    -- Snippets
    use(
      {
        "L3MON4D3/luasnip",
        requires = {
          "rafamadriz/friendly-snippets"
        },
        config = config("luasnip")
      }
    )
    use {"saadparwaiz1/cmp_luasnip", after = "nvim-cmp"}
    use {"hrsh7th/cmp-nvim-lua", after = "nvim-cmp"}
    use {"hrsh7th/cmp-nvim-lsp", after = "cmp-nvim-lua"}
    use {"hrsh7th/cmp-buffer", after = "cmp-nvim-lsp"}
    use {"hrsh7th/cmp-path", after = "cmp-buffer"}
    use {"hrsh7th/cmp-calc", after = "cmp-path"}

    -- LSP stuf:
    use "neovim/nvim-lspconfig"
    use {"williamboman/nvim-lsp-installer", after = "cmp-nvim-lsp", config = "require('lsp.installer')"}
    use_with_config("jose-elias-alvarez/null-ls.nvim", "null-ls")

    -- LSP Addons
    use {"tami5/lspsaga.nvim", config = config("saga")}
    use {"onsails/lspkind-nvim"}
    use {"folke/lsp-trouble.nvim", config = config("lsp-trouble")}
    use {"nvim-lua/popup.nvim"}
    use {"jose-elias-alvarez/nvim-lsp-ts-utils", after = {"nvim-treesitter"}}
    use_with_config("mhartington/formatter.nvim", "formatter")

    -- Snippets & Language & Syntax
    use {"windwp/nvim-autopairs", after = {"nvim-treesitter", "nvim-cmp"}, config = config("autopairs")}
    use {"mattn/emmet-vim"}
    use {"potatoesmaster/i3-vim-syntax"}
    use {"lpinilla/vim-codepainter"}

    -- treesitter
    use(
      {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = config("treesitter")
      }
    )
    use(
      {
        "RRethy/nvim-treesitter-textsubjects", -- adds smart text objects
        ft = {"lua", "typescript", "typescriptreact"}
      }
    )
    use({"windwp/nvim-ts-autotag", ft = {"typescript", "typescriptreact"}}) -- automatically close jsx tags
    use({"JoosepAlviste/nvim-ts-context-commentstring", ft = {"typescript", "typescriptreact"}}) -- makes jsx comments actually work

    -- Tmux
    use(
      {
        "aserowy/tmux.nvim",
        config = function()
          require("tmux").setup(
            {
              -- overwrite default configuration
              -- here, e.g. to enable default bindings
              copy_sync = {
                -- enables copy sync and overwrites all register actions to
                -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
                enable = true
              },
              navigation = {
                -- enables default keybindings (C-hjkl) for normal mode
                enable_default_keybindings = true
              },
              resize = {
                -- enables default keybindings (A-hjkl) for normal mode
                enable_default_keybindings = true
              }
            }
          )
        end
      }
    )
    -- Misc
    use("nvim-lua/plenary.nvim")
    use_with_config("nathom/filetype.nvim", "filetype") -- greatly reduces startup time
    use {
      "luukvbaal/stabilize.nvim",
      config = function()
        require("stabilize").setup()
      end
    }
  end
)
