return {
  "tpope/vim-fugitive",
  cmd = { "Git", "G", "Gwrite", "Gread", "Gdiffsplit", "Gvdiffsplit" },
  keys = {
    { "<leader>gB", "<cmd>Git blame<cr>", desc = "Git blame (fugitive)" },
  },
}
