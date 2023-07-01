return {
  "akinsho/git-conflict.nvim",
  version = "v1.1.2",
  keys = {
    { "<leader>gml", "<cmd>GitConflictListQf<cr>", desc = "List conflicts" },
    { "<leader>gmo", "<cmd>GitConflictChooseOurs<cr>", desc = "Merge OUR change" },
    { "<leader>gmt", "<cmd>GitConflictChooseTheirs<cr>", desc = "Merge THEIR changes" },
    { "<leader>gmt", "<cmd>GitConflictChooseBoth<cr>", desc = "Merge BOTH changes" },
  },
  config = function()
    require("git-conflict").setup({
      default_mappings = false, -- disable buffer local mapping created by this plugin
      default_commands = true, -- disable commands created by this plugin
      disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
      highlights = { -- They must have background color, otherwise the default color will be used
        incoming = "DiffAdd",
        current = "DiffText",
      },
    })
  end,
}
