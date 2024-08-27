return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  ---@class avante.Config
  opts = {
    provider = "copilot",
    copilot = {
      endpoint = "https://api.githubcopilot.com",
      model = "gpt-4o-2024-05-13",
      proxy = nil, -- [protocol://]host[:port] Use this proxy
      allow_insecure = false, -- Allow insecure server connections
      timeout = 30000, -- Timeout in milliseconds
      temperature = 0,
      max_tokens = 4096,
    },
    ---@class AvanteHintsConfig
    ---@field enabled boolean
    hints = {
      enabled = true,
    },
    --- @class AvanteConflictUserConfig
    diff = {
      autojump = true,
      list_opener = "copen",
    },
    windows = {
      wrap = true, -- similar to vim.o.wrap
      width = 25, -- default % based on available width
      sidebar_header = {
        align = "left", -- left, center, right for title
        rounded = false,
      },
    },
  },
}
