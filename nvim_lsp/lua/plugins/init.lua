return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Theme
  use({'ayu-theme/ayu-vim', config = function()
      vim.o.background = "dark"
      vim.g.ayucolor = "mirage"
      vim.cmd([[colorscheme ayu]])
    end})

  -- Syntax highlighting
  use({ "nvim-treesitter/nvim-treesitter" }) -- syntax highlight indent etc

  -- Create folders if not existing
  use({
    "jghauser/mkdir.nvim",
    config = function()
      require("mkdir")
    end,
  })

  -- LSP
  --- default configs for lsp and setup lsp
  use({
    "neovim/nvim-lspconfig",
    config = require("plugins.lspconfig").init,
    requires = {
      "nvim-lua/lsp-status.nvim",
      after = { "neovim/nvim-lspconfig" },
    },
  })
  --- CMP completion engine
  use({
    "hrsh7th/nvim-cmp",
    config = require("plugins.cmp").init,
    requires = {
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
      {
        "kristijanhusak/orgmode.nvim",
        config = function()
          require("orgmode").setup({
            org_agenda_files = { "~/org/*" },
            org_default_notes_file = "~/org/refile.org",
          })
        end,
        keys = { "<space>oc", "<space>oa" },
        ft = { "org" },
        wants = "nvim-cmp",
      },
    },
  }) 

  -- lsp status
  use({
    "nvim-lua/lsp-status.nvim",
  })

  -- LSP extensions stuff
  use({
    "onsails/lspkind-nvim",
    config = function()
      require("lspkind").init({
        -- enables text annotations
        --
        -- default: true
        with_text = true,

        -- default symbol map
        -- can be either 'default' (requires nerd-fonts font) or
        -- 'codicons' for codicon preset (requires vscode-codicons font)
        --
        -- default: 'default'
        preset = "codicons",

        -- override preset symbols
        --
        -- default: {}
        symbol_map = {
          Text = "",
          Method = "",
          Function = "",
          Constructor = "",
          Field = "ﰠ",
          Variable = "",
          Class = "ﴯ",
          Interface = "",
          Module = "",
          Property = "ﰠ",
          Unit = "塞",
          Value = "",
          Enum = "",
          Keyword = "",
          Snippet = "",
          Color = "",
          File = "",
          Reference = "",
          Folder = "",
          EnumMember = "",
          Constant = "",
          Struct = "פּ",
          Event = "",
          Operator = "",
          TypeParameter = "",
        },
      })
    end,
  }) 

  use({
    "folke/lsp-colors.nvim",
    config = function()
      require("lsp-colors").setup({
        Error = "#db4b4b",
        Warning = "#e0af68",
        Information = "#0db9d7",
        Hint = "#10B981",
      })
    end,
  })

  -- Colors hex
  use({
    "norcalli/nvim-colorizer.lua",
    ft = {
      "css",
      "scss",
      "sass",
      "javascriptreact",
      "typescriptreact",
      "lua",
    },
    config = function()
      require("colorizer").setup()
    end,
  })

  -- Tree drawer
  use({
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
    config = require("plugins.nvimTree").init,
    cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
  }) -- Drawerboard style like nerdtree

  --Fuzzy finder
  use({
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    config = require("plugins.telescope").init,
    requires = {
      { "nvim-lua/plenary.nvim", opt = true },
      { "nvim-telescope/telescope-project.nvim", opt = true },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        opt = true,
        run = "make",
      },
    },
  })

  -- Bufferline
  use({ "romgrk/barbar.nvim", requires = "kyazdani42/nvim-web-devicons" }) 

  -- TS
  --- autotag <>
  use({
    "windwp/nvim-ts-autotag",
    ft = { "typescriptreact", "javascriptreact", "html" },
  }) 
  --- Autopairs
  use({ "windwp/nvim-autopairs" }) -- autopairs "" {}



end)

