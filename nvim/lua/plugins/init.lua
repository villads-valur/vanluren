local plugins = {
 "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
}
local opts = {}

require("lazy").setup(plugins, opts)

