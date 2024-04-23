return {
  -- Lua
  "folke/zen-mode.nvim",
  cmd = {
    "ZenMode",
  },
  keys = {
    { "<leader>zt", "<CMD>ZenMode<CR>", desc = "Toggle Zen Mode" },
  },
  opts = {
    window = {
      backdrop = 0.95,
      width = 120, -- width of the Zen window
      height = 1, -- height of the Zen window
      -- uncomment any of the options below, or add other vim.wo options you want to apply
      options = {
        -- signcolumn = "no", -- disable signcolumn
        -- number = false, -- disable number column
        -- relativenumber = false, -- disable relative numbers
        cursorline = false, -- disable cursorline
        -- cursorcolumn = false, -- disable cursor column
        -- foldcolumn = "0", -- disable fold column
        -- list = false, -- disable whitespace characters
      },
    },
    plugins = {
      options = {
        enabled = true,
        ruler = false, -- disables the ruler text in the cmd line area
        showcmd = false, -- disables the command in the last line of the screen
      },
      twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
      gitsigns = { enabled = true }, -- disables git signs
      tmux = { enabled = true }, -- disables the tmux statusline
    },
  },
}
