function light()
  vim.cmd("set background=light")
  vim.cmd("colorscheme ayu-light")
end

function dark()
  vim.cmd("set background=dark")
  vim.cmd("colorscheme one-half-dark")
end

return {
  {
    "Shatur/neovim-ayu",
    lazy = true,
    priority = 1000,
    config = function()
      vim.cmd("command Light silent lua light()")
    end,
  },
  {
    "Vanluren/neovim-onehalf",
    -- dir = "~/Developer/personal/neovim-onehalf/",
    name = "neovim-onehalf",
    lazy = false,
    priority = 1000,
  },
}
