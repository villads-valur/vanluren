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

  use({
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = config("nvim-tree"),
  })


  -- UI
  use {
      "ayu-theme/ayu-vim",
      config = config("ayu")
   } 
 

  --tresitter
  use({
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    config = config("treesitter"),
    run = ":TSUpdate"
  })



  -- LSP 
   use {
      "neovim/nvim-lspconfig",
      opt = true,
      setup = function()
         require("utils").packer_lazy_load "nvim-lspconfig"
         -- reload the current file so lsp actually starts for it
         vim.defer_fn(function()
            vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
         end, 0)
      end,
      config = config("lsp-config"),
   }

   use { "williamboman/nvim-lsp-installer" }


  -- Null Ls
   use {
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
      config = config("null-ls")
   }

   use {
      "andymass/vim-matchup",
      opt = true,
      setup = function()
         require("utils").packer_lazy_load "vim-matchup"
      end,
   }

   use {
      "max397574/better-escape.nvim",
      event = "InsertEnter",
      config = config("better-escape"),
   }end)
