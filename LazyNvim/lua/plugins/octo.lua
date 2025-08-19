return {
  "pwntester/octo.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
    "folke/snacks.nvim",
  },
  opts = {
    use_local_fs = true,
  },
  keys = {
    {
      "<Leader>gop",
      "<cmd>Octo pr list<CR>",
      desc = "Toggle PR List",
    },
    {
      "<Leader>goi",
      "<cmd>Octo issue list<CR>",
      desc = "Toggle Issue List",
    },
    {
      "<Leader>gors",
      "<cmd>Octo review start<CR>",
      desc = "Start Review",
    },
    {
      "<Leader>gorS",
      "<cmd>Octo review submit<CR>",
      desc = "Submit Review",
    },
    {
      "<Leader>goca",
      "<cmd>Octo comment add<CR>",
      desc = "Add Comment",
    },
  },
}
