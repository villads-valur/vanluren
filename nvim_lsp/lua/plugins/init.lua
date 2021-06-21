require 'paq-nvim' {
    'savq/paq-nvim';                  -- Let Paq manage itself

    -- Essentials
    'tpope/vim-commentary';
    'tpope/vim-surround';

    -- LSP and language stuff
    'neovim/nvim-lspconfig';          
    'kabouzeid/nvim-lspinstall'; 
    'onsails/lspkind-nvim';
    "jose-elias-alvarez/nvim-lsp-ts-utils"; 
    "jose-elias-alvarez/null-ls.nvim"; 
    'nvim-treesitter/nvim-treesitter'; 
    'hrsh7th/nvim-compe';
    'nvim-lua/completion-nvim';
    {"RRethy/vim-illuminate", as="illuminate"};


    'sbdchd/neoformat';
    'windwp/nvim-autopairs';
    'nvim-lua/plenary.nvim';
    'nvim-lua/popup.nvim';

    'lewis6991/gitsigns.nvim';
    'akinsho/nvim-bufferline.lua';
    'glepnir/galaxyline.nvim';
    'alvan/vim-closetag';

    -- Theming:
    'glepnir/zephyr-nvim';
    { 'edkolev/tmuxline.vim', as="tmuxline"};


    -- Telescope
   'nvim-telescope/telescope.nvim';
   'nvim-telescope/telescope-media-files.nvim';
   

   -- File browsing
    'kyazdani42/nvim-web-devicons'; --for file icons
    'kyazdani42/nvim-tree.lua';

    -- Movement
    'qpkorr/vim-bufkill';
    'easymotion/vim-easymotion';


}
