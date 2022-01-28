
-- Plugin manager configuration file
local cmd = vim.cmd
cmd [[packadd packer.nvim]]

local packer = require 'packer'

local use = packer.use

local config = function(name)
	return string.format("require('plugins.%s')", name)
end

-- Add packages
return packer.startup(function()
  use 'wbthomason/packer.nvim' -- packer can manage itself

  -- dashboard
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- colorschemes
  use {
    "Shatur/neovim-ayu",
    config = config("ayu")
  }

  use{
    "LunarVim/onedarker.nvim",
  }

end)
