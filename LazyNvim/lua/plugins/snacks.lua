return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = [[
 			██╗  ██╗███████╗██╗     ██╗      ██████╗        ██╗
			██║  ██║██╔════╝██║     ██║     ██╔═══██╗    ██╗╚██╗
			███████║█████╗  ██║     ██║     ██║   ██║    ╚═╝ ██║
			██╔══██║██╔══╝  ██║     ██║     ██║   ██║    ██╗ ██║
			██║  ██║███████╗███████╗███████╗╚██████╔╝    ╚═╝██╔╝
			╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝ ╚═════╝        ╚═╝
        ]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find file", action = "<CMD>Telescope find_files<CR>" },
          { icon = " ", key = "r", desc = "Recent files", action = "<CMD>Telescope oldfiles<CR>" },
          { icon = " ", key = "u", desc = "Update plugins", action = "<CMD>Lazy update<CR>" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa<CR>" },

        },
      },
    },
  },
  keys = {
    { "<leader>n", false },
  },
}
