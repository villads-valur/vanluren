return {
  "olimorris/codecompanion.nvim",
  event = "LspAttach",
  opts = {
    display = {
      action_palette = {
        width = 95,
        height = 10,
        prompt = "Prompt ", -- Prompt used for interactive LLM calls
        provider = "telescope", -- Can be "default", "telescope", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
        opts = {
          show_default_actions = true, -- Show the default actions in the action palette?
          show_default_prompt_library = true, -- Show the default prompt library in the action palette?
        },
      },
      diff = {
        enabled = false, -- Enable the diff view?
      },
    },
    adapters = {
      openai = function()
        return require("codecompanion.adapters").extend("openai", {
          schema = {
            model = {
              default = "o4-mini-2025-04-16",
            },
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = "openai",
      },
      inline = {
        adapter = "openai",
      },
    },
    prompt_library = {
      ["Optimize Code"] = {
        strategy = "chat",
        description = "Optimize the selected code for readability issues.",
        prompt = {
          {
            role = "system",

            content = function(ctx)
              return "I want you to act like a Senior"
                .. ctx.filetype
                .. "developer. Suggest optimizations the selected code for readability and perfomance issues. Some readability issues to consider:\n- Unclear naming\n- Unclear purpose\n- Redundant or obvious comments\n- Lack of comments\n- Long or complex one liners\n- Too much nesting\n- Long variable names\n- Inconsistent naming and code style\n- Code repetition\n- Inefficient code\n- Unnecessary code.\n Suggest the updated code."
            end,
          },
          {
            role = "user",
            content = function(context)
              local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
              return "I have the following code:\n\n```" .. context.filetype .. "\n" .. text .. "\n```\n\n"
            end,
            opts = {
              contains_code = true,
            },
          },
        },
        opts = {
          mapping = "<LocalLeader>ao",
          modes = { "v" },
          auto_submit = true,
          short_name = "optimize",
          stop_context_insertion = true,
          user_prompt = true,
        },
      },
      ["Hello"] = {
        strategy = "chat",
        description = "Greet the user",
        prompt = {
          { role = "system", content = "You are a helpful assistant." },
          { role = "user", content = "Hello!" },
        },
        opts = {
          mapping = "/hello",
          modes = { "n" },
          auto_submit = true,
          short_name = "hello",
        },
      },
      ["Explain Code"] = {
        strategy = "chat",
        description = "Explain the selected code",
        prompt = {
          {
            role = "system",
            content = function(context)
              return "I want you to act as a senior "
                .. context.filetype
                .. " developer. I will ask you specific questions and I want you to return concise explanations and codeblock examples."
            end,
          },
          {
            role = "user",
            content = function(context)
              local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

              return "I have the following code:\n\n```" .. context.filetype .. "\n" .. text .. "\n```\n\n"
            end,
            opts = {
              contains_code = true,
            },
          },
        },
        opts = {
          mapping = "<LocalLeader>ax",
          modes = { "v" },
          auto_submit = true,
          short_name = "explain",
          stop_context_insertion = true,
          user_prompt = true,
        },
      },
      ["Add Docstring"] = {
        strategy = "chat",
        description = "Add docstring to the selected code",
        prompt = "Add docstring to the selected code.",
      },
      ["Fix Bugs"] = {
        strategy = "chat",
        description = "Fix the bugs inside the selected code if any.",
        prompt = "Fix the bugs inside the selected code if any.",
      },
      ["Add Tests"] = {
        strategy = "chat",
        description = "Implement tests for the selected code.",
        prompt = "Implement tests for the selected code.",
      },
    },
  },
  keys = {
    { "<leader>aa", "<cmd>CodeCompanion Toggle<cr>", desc = "Code Companion" },
    { "<leader>ab", "<cmd>CodeCompanion /buffer<cr>", desc = "Add Buffer to " },

    { "<leader>ac", "<cmd>CodeCompanionActions<cr>", desc = "Code Companion Actions" },
    { "<leader>aC", "<cmd>CodeCompanionChat<cr>", desc = "Code Companion Chat" },
    { "<leader>aI", "<cmd>CodeCompanionInline<cr>", desc = "Code Companion Inline" },
    { "<leader>aD", "<cmd>CodeCompanionDiff<cr>", desc = "Code Companion Diff" },
    {
      "<leader>ao",
      mode = { "v" },
      "<cmd>CodeCompanion /hello<cr>",
      desc = "Optimize Selected Code",
    },
    {
      "<leader>ax",
      mode = { "v" },
      "<cmd>CodeCompanion /explain<cr>",
      desc = "Explain Selected Code",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}
