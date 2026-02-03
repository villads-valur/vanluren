return {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope", "TelescopePrompt", "TelescopeResults" },
  keys = function()
    return {
      { "<leader>T", LazyVim.pick("auto"), desc = "Find Files (Root Dir)" },
      { "<leader>t", LazyVim.pick("auto", { root = false }), desc = "Find Files (cwd)" },
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Search (Grep)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Find Recent" },
    }
  end,
  opts = function()
    local actions = require("telescope.actions")

    local find_files_no_ignore = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      LazyVim.pick("find_files", { no_ignore = true, default_text = line })()
    end
    local find_files_with_hidden = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      LazyVim.pick("find_files", { hidden = true, default_text = line })()
    end

    return {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        -- open files in the first window that is an actual file.
        -- use the current window if no other window is available.
        get_selection_window = function()
          local wins = vim.api.nvim_list_wins()
          table.insert(wins, 1, vim.api.nvim_get_current_win())
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == "" then
              return win
            end
          end
          return 0
        end,
        mappings = {
          i = {
            ["<a-i>"] = find_files_no_ignore,
            ["<a-h>"] = find_files_with_hidden,
            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<C-f>"] = actions.preview_scrolling_down,
            ["<C-b>"] = actions.preview_scrolling_up,
            ["<ESC>"] = actions.close,
          },
          n = {
            ["q"] = actions.close,
            ["<ESC>"] = actions.close,
          },
        },
      },
    }
  end,
}
