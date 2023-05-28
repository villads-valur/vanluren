return {
  "Shatur/neovim-ayu",
  lazy = true,
  priority = 1000,
  config = function()
    vim.cmd("colorscheme ayu-light")
    vim.cmd("set bg=light")
  end,
}
