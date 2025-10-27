return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = function()
    LazyVim.cmp.actions.ai_accept = function()
      if require("copilot.suggestion").is_visible() then
        LazyVim.create_undo()
        require("copilot.suggestion").accept()
        return true
      end
    end

    return {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = vim.g.ai_cmp,
        keymap = {
          accept = "<C-j>", -- handled by nvim-cmp / blink.cmp
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
      auto_refresh = true,
    }
  end,
}
