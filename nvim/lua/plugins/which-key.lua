return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = { spelling = true },
    defaults = {
      mode = { "n", "v" },
      ["z"] = { name = "+fold" },
      ["<leader>b"] = { name = "[B]uffer" },
      ["<leader>c"] = { name = "[C]ode" },
      ["<leader>f"] = { name = "[F]ile/find" },
      ["<leader>g"] = { name = "[G]it" },
      ["<leader>gh"] = { name = "[H]unks" },
      ["<leader>q"] = { name = "[Q]uit" },
      ["<leader>s"] = { name = "[S]earch" },
      ["<leader>u"] = { name = "[U]i" },
      ["<leader>ww"] = { name = "[W]indows" },
      ["<leader>x"] = { name = "[D]iagnostics/quickfix" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
