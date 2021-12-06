-- Setup global configuration. More on configuration below.
local cmp = require("cmp")
local icons = require("icons")
local lspkind = require("lspkind")
--[[ local tabnine = require("cmp_tabnine.config") ]]
local source_mapping = {
  buffer = icons.buffer .. "[BUF]",
  calc = icons.calculator,
  npm = icons.terminal .. "[NPM]",
  nvim_lsp = icons.paragraph .. "[LSP]",
  nvim_lua = icons.bomb,
  path = icons.folderOpen2,
  treesitter = icons.tree,
  ultisnips = icons.snippet,
  zsh = icons.terminal .. "[ZSH]"
}

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end
  },
  -- You must set mapping if you want.
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({select = true}),
    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), {"i", "s"}),
    ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), {"i", "s"})
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lspkind.symbolic(vim_item.kind, {with_text = true})
      local menu = source_mapping[entry.source.name]
      local maxwidth = 50

      -- if entry.source.name == "cmp_tabnine" then
      --   if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
      --     menu = menu .. "[" .. entry.completion_item.data.detail .. "]"
      --   end
      -- end

      vim_item.menu = menu
      vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)

      return vim_item
    end
  },
  -- You should specify your *installed* sources.
  sources = {
    {name = "nvim_lsp"},
    {name = "npm"},
    {name = "ultisnips"},
    {name = "buffer", keyword_length = 5},
    {name = "path"},
    {name = "calc"},
    {name = "nvim_lua"}
  },
  experimental = {
    native_menu = false,
    ghost_text = true
  }
}

-- tabnine:setup(
--   {
--     max_lines = 1000,
--     max_num_results = 3,
--     sort = true,
--     show_prediction_strength = true
--   }
-- )
