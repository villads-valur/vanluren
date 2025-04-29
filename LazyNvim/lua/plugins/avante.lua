-- Function to get the visually selected text
local function get_visual_selection()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  if #lines == 0 then
    return ""
  end

  -- Handle the first and last line selections that might be partial
  if #lines == 1 then
    lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
  else
    lines[1] = string.sub(lines[1], start_pos[3])
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
  end

  return table.concat(lines, "\n")
end

-- Ask Avante with a question template that includes the selected code
local ask_avante_with_selection = function(question_template)
  local selected_code = get_visual_selection()

  -- Format the question with the selected code
  local formatted_question = question_template:gsub("{{selection}}", selected_code)
  require("avante.api").ask({ question = formatted_question })
end

-- Templates with placeholders for selected code
local avante_question_templates = {
  grammar_correction = "Correct the text to standard English, but keep any code blocks inside intact.",
  keywords = "Extract the main keywords from the selected text.",
  code_readability = "Optimize the selected code for readability issues. Some readability issues to consider:\n- Unclear naming\n- Unclear purpose\n- Redundant or obvious comments\n- Lack of comments\n- Long or complex one liners\n- Too much nesting\n- Long variable names\n- Inconsistent naming and code style\n- Code repetition\n- Inefficient code\n- Unnecessary code.\n Suggest the updated code.",
  explain_code = "Explain the selected code",
  complete_code = "Complete the selected code written in " .. vim.bo.filetype .. ".",
  add_docstring = "Add docstring to the selected code.",
  fix_bugs = "Fix the bugs inside the selected code if any.",
  add_tests = "Implement tests for the selected code.",
}

---@class avante.CoreConfig: avante.Config
return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  build = "make",
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
    provider = "openai",
    openai = {
      endpoint = "https://api.openai.com/v1",
      model = "o4-mini-2025-04-16",
      timeout = 30000, -- Timeout in milliseconds
      max_completion_tokens = 4096,
    },
    -- copilot = {
    --   endpoint = "https://api.githubcopilot.com",
    --   model = "gpt-4o-2024-08-06",
    --   allow_insecure = false, -- Allow insecure server connections
    --   timeout = 30000, -- Timeout in milliseconds
    --   temperature = 0,
    --   max_tokens = 4096,
    -- },
    dual_boost = {
      enabled = false,
      first_provider = "openai",
      second_provider = "copilot",
      prompt = "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
      timeout = 60000, -- Timeout in milliseconds
    },
    behavior = {
      auto_suggestions = true,
      support_paste_from_clipboard = true,
    },
    hints = {
      enabled = true,
    },
    diff = {
      autojump = true,
      list_opener = "copen",
    },
    windows = {
      wrap = true, -- similar to vim.o.wrap
      width = 30, -- default % based on available width
      sidebar_header = {
        align = "left", -- left, center, right for title
        rounded = false,
      },
      ask = {
        floating = false, -- Open the 'AvanteAsk' prompt in a floating window
        start_insert = true, -- Start insert mode when opening the ask window
        focus_on_apply = "ours", -- which diff to focus after applying
      },
    },
  },
  keys = {
    -- Updated keybindings that use the new function with templates
    {
      "<Leader>ao",
      function()
        ask_avante_with_selection(avante_question_templates.code_readability)
      end,
      mode = { "v" },
      desc = "Optimize code readability",
    },
    {
      "<Leader>ag",
      function()
        ask_avante_with_selection(avante_question_templates.grammar_correction)
      end,
      mode = { "v" },
      desc = "Correct grammar",
    },
    {
      "<leader>ax",
      function()
        ask_avante_with_selection(avante_question_templates.explain_code)
      end,
      desc = "Explain Code",
      mode = { "v" },
    },
    {
      "<leader>ac",
      function()
        ask_avante_with_selection(avante_question_templates.complete_code)
      end,
      desc = "Complete Code",
      mode = { "v" },
    },
    {
      "<leader>ad",
      function()
        ask_avante_with_selection(avante_question_templates.add_docstring)
      end,
      desc = "Add Docstring",
      mode = { "v" },
    },
    {
      "<leader>af",
      function()
        ask_avante_with_selection(avante_question_templates.fix_bugs)
      end,
      desc = "Fix Bugs",
      mode = { "v" },
    },
    {
      "<leader>at",
      function()
        ask_avante_with_selection(avante_question_templates.add_tests)
      end,
      desc = "Add Tests",
      mode = { "v" },
    },
    {
      "<leader>ak",
      function()
        ask_avante_with_selection(avante_question_templates.keywords)
      end,
      desc = "Extract Keywords",
      mode = { "v" },
    },
    {
      "<leader>az",
      function()
        ask_avante_with_selection(avante_question_templates.optimize_code)
      end,
      desc = "Optimize Code",
      mode = { "v" },
    },
  },
}
