return {
  "nvim-pack/nvim-spectre",
  keys = {
    {
      "<leader>sr",
      function()
        require("spectre").open()
      end,
      desc = "Search and Replace",
    },
    {
      "<leader>sR",
      function()
        require("spectre").open_visual({ select_word = true })
      end,
      desc = "Search and Replace (Visual)",
    },
    {
      "<leader>sw",
      function()
        require("spectre").open_visual({ select_word = false })
      end,
      desc = "Search and Replace (Visual Word)",
    },
  },
}
