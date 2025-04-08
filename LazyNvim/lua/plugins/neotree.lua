return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = function()
    return {
      {
        "<leader>n",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree",
        remap = true,
      },
      {
        "<leader>N",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").root.get() })
        end,
        desc = "Explorer NeoTree (root)",
        remap = true,
      },
    }
  end,
  opts = {
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = {
        enabled = true,
      },
      use_libuv_file_watcher = true,
      filtered_items = {
        always_show_by_pattern = { -- uses glob style patterns
          ".github*",
          ".gitignore",
          ".prettierrc",
          ".eslintrc",
          "ælakdsfjadf",
        },
      },
    },
    window = {
      mappings = {
        ["<space>"] = "none",
      },
      position = "right",
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
    },
  },
}
