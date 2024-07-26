return {
  "echasnovski/mini.surround",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    mappings = {
      add = "S", -- Add surrounding in Normal and Visual modes
      delete = "dS", -- Delete surrounding
      find = "fS", -- Find surrounding (to the right)
      find_left = "FS", -- Find surrounding (to the left)
      highlight = "HS", -- Highlight surrounding
      replace = "rS", -- Replace surrounding
    },
  },
}
