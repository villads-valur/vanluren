local ts_config = require("nvim-treesitter")

ts_config.setup {
   ensure_installed = {
      "lua",
      "vim",
      "typescript",
      "javascript"
   },
   highlight = {
      enable = true,
      use_languagetree = true,
   },
}
