return {
  "olimorris/onedarkpro.nvim",
  lazy = true,
  priority = 1000,
  config = function()
    require("onedarkpro").setup({
      caching = true,
      theme = "onedark_dark",
      colors = {
        bg = "#1F1F28",
        cursorline = "#2A2A37", -- This is optional. The default cursorline color is based on the background
      },
      options = {
        cursorline = true,
      },
    })
  end,
}
