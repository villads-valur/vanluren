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
    copilot_node_command = vim.fn.expand("$NVM_DIR") .. "/versions/node/v20.3.1/bin/node", -- Node.js version must be > 16.x
  },
}
