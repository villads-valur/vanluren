return {
  "Bryley/neoai.nvim",
  enable = false,
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  cmd = {
    "NeoAI",
    "NeoAIOpen",
    "NeoAIClose",
    "NeoAIToggle",
    "NeoAIContext",
    "NeoAIContextOpen",
    "NeoAIContextClose",
    "NeoAIInject",
    "NeoAIInjectCode",
    "NeoAIInjectContext",
    "NeoAIInjectContextCode",
  },
  keys = {
    { "<leader>as", desc = "summarize text" },
    { "<leader>ag", desc = "generate git message" },
    { "<leader>ao", "<CMD>NeoAIOpen<CR>", desc = "open NeoAi" },
    { "<leader>ac", "<CMD>NeoAIContext<CR>", desc = "open NeoAiContext" },
  },
  config = function()
    require("neoai").setup()
  end,
}
