return {
  "georgeguimaraes/review.nvim",
  dependencies = {
    "esmuellert/codediff.nvim",
    "MunifTanjim/nui.nvim",
  },
  cmd = { "Review" },
  keys = {
    { "<leader>gRo", "<cmd>Review<CR>", desc = "Open Review" },
    { "<leader>gRc", "<cmd>Review commits<CR>", desc = "Review Commits" },
    { "<leader>gRl", "<cmd>Review list<CR>", desc = "List Comments" },
    { "<leader>gRe", "<cmd>Review export<CR>", desc = "Export Comments" },
    { "<leader>gRp", "<cmd>Review preview<CR>", desc = "Preview Export" },
    { "<leader>gRx", "<cmd>Review clear<CR>", desc = "Clear Comments" },
    { "<leader>gRt", "<cmd>Review toggle<CR>", desc = "Toggle Readonly" },
  },
  opts = {
    codediff = {
      readonly = true,
    },
    keymaps = {
      -- Readonly mode keymaps (these don't conflict)
      readonly_add = "i",      -- Add comment (pick type from menu)
      readonly_delete = "d",   -- Delete comment at cursor
      readonly_edit = "e",     -- Edit comment at cursor

      -- Navigation (]n/[n don't conflict)
      next_comment = "]n",
      prev_comment = "[n",

      -- These conflict with your mappings, so remap them:
      next_file = "<C-n>",     -- Was <Tab> (conflicts with buffer nav)
      prev_file = "<C-p>",     -- Was <S-Tab> (conflicts with buffer nav)

      -- Actions that don't conflict
      toggle_file_panel = "f",
      list_comments = "c",
      export_clipboard = "C",
      send_sidekick = "S",
      clear_comments = "<C-x>",  -- Was <C-r> (might conflict with redo)
      close = "q",
      toggle_readonly = "R",

      -- Edit mode keymaps (disabled since we use readonly mode)
      -- These would conflict with your mappings
      add_note = false,        -- Was <leader>cn (conflicts with toggle rnu)
      add_suggestion = false,  -- Was <leader>cs
      add_issue = false,       -- Was <leader>ci
      add_praise = false,      -- Was <leader>cp
      delete_comment = false,  -- Was <leader>cd (conflicts with diagnostics)
      edit_comment = false,    -- Was <leader>ce
    },
  },
}
