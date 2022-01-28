-- Plugin manager configuration file
local cmd = vim.cmd

cmd [[packadd packer.nvim]]

local packer = require('packer')

local use = packer.use

local config = function(name)
	return string.format("require('plugins.%s')", name)
end

return packer.startup(function()
  use {
   'wbthomason/packer.nvim',
   event = 'VimEnter'
 } -- packer can manage itself

  use 'nvim-lua/plenary.nvim'

  -- tpope essentials
  use 'tpope/vim-surround'

  -- icons
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

  -- telescope
  use {
    'nvim-telescope/telescope.nvim',
    config = config('telescope'),
  }


end)
