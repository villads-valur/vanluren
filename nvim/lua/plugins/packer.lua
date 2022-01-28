-- Plugin manager configuration file
local cmd = vim.cmd

cmd [[packadd packer.nvim]]

local packer = require('packer')

local use = packer.use

local config = function(name)
	return string.format("require('plugins.%s')", name)
end

return packer.startup(function()
  use 'wbthomason/packer.nvim' -- packer can manage itself

  -- tpope essentials
  use 'tpope/vim-surround'

  -- UI
  use 'kyazdani42/nvim-web-devicons'


  -- dashboard
  use {
    'goolord/alpha-nvim',
    after = 'nvim-web-devicons',
    config = config('alpha')
  }

  --- colorschemes
  use {
    'Shatur/neovim-ayu',
    config = config('ayu')
  }

  use 'LunarVim/onedarker.nvim'


  --- statusline
   use {
      'feline-nvim/feline.nvim',
      after = 'nvim-web-devicons',
      config = config('feline')
   }

  --- tree view
  use {
      'kyazdani42/nvim-tree.lua',
      after = 'nvim-web-devicons', -- optional, for file icon
      config = config('nvim-tree')
  }

end)
