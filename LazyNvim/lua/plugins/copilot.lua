return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    auto_refresh = true,
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<C-j>",
      },
    },
  },
}
