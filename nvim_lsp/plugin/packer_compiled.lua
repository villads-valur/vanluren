-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/villadsvalur/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/villadsvalur/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/villadsvalur/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/villadsvalur/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/villadsvalur/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    loaded = true,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["ayu-vim"] = {
    config = { "\27LJ\2\nw\0\0\3\0\t\0\r6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\4\0'\1\6\0=\1\5\0006\0\0\0009\0\a\0'\2\b\0B\0\2\1K\0\1\0\20colorscheme ayu\bcmd\vmirage\rayucolor\6g\tdark\15background\6o\bvim\0" },
    loaded = true,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/start/ayu-vim",
    url = "https://github.com/ayu-theme/ayu-vim"
  },
  ["barbar.nvim"] = {
    loaded = true,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/start/barbar.nvim",
    url = "https://github.com/romgrk/barbar.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["lsp-colors.nvim"] = {
    config = { "\27LJ\2\n~\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\4\16Information\f#0db9d7\fWarning\f#e0af68\tHint\f#10B981\nError\f#db4b4b\nsetup\15lsp-colors\frequire\0" },
    loaded = true,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim",
    url = "https://github.com/folke/lsp-colors.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/start/lsp-status.nvim",
    url = "https://github.com/nvim-lua/lsp-status.nvim"
  },
  ["lspkind-nvim"] = {
    config = { "\27LJ\2\në\3\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\15symbol_map\1\0\25\rConstant\bÔ£æ\fSnippet\bÔëè\vStruct\bÔ≠Ñ\fKeyword\bÔ†ä\nEvent\bÔÉß\tEnum\bÔÖù\rOperator\bÔöî\nValue\bÔ¢ü\18TypeParameter\5\tUnit\bÔ•¨\rProperty\bÔ∞†\vModule\bÔíá\14Interface\bÔÉ®\nClass\bÔ¥Ø\rVariable\bÔî™\nField\bÔ∞†\16Constructor\bÔê£\15EnumMember\bÔÖù\rFunction\bÔûî\vFolder\bÔùä\vMethod\bÔö¶\14Reference\bÔúÜ\tText\bÔùæ\tFile\bÔúò\nColor\bÔ£ó\1\0\2\14with_text\2\vpreset\rcodicons\tinit\flspkind\frequire\0" },
    loaded = true,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["mkdir.nvim"] = {
    config = { "\27LJ\2\n%\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\nmkdir\frequire\0" },
    loaded = true,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/start/mkdir.nvim",
    url = "https://github.com/jghauser/mkdir.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\n¨\1\0\2\5\1\b\0\15-\2\0\0009\2\1\0029\2\2\0029\3\0\0018\2\3\2'\3\3\0009\4\0\1&\2\4\2=\2\0\0015\2\5\0009\3\6\0009\3\a\0038\2\3\2=\2\4\1L\1\2\0\1¿\tname\vsource\1\0\4\rnvim_lua\n[Lua]\rnvim_lsp\n[LSP]\fluasnip\14[LuaSnip]\tpath\v[Path]\tmenu\6 \fdefault\fpresets\tkindC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequireü\2\0\1\t\3\n\0--\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1#Ä-\1\1\0\15\0\1\0X\2\vÄ-\1\1\0009\1\2\1)\3ˇˇB\1\2\2\15\0\1\0X\2\5Ä-\1\1\0009\1\3\1)\3ˇˇB\1\2\1X\1\21Ä-\1\2\0B\1\1\2\15\0\1\0X\2\15Ä6\1\4\0009\1\5\0019\1\6\0016\3\4\0009\3\5\0039\3\a\3'\5\b\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\t\0+\5\2\0B\1\4\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\2¿\0\0\6n\f<s-tab>\27nvim_replace_termcodes\18nvim_feedkeys\bapi\bvim\tjump\rjumpable\21select_prev_item\fvisibleÔ\3\0\1\n\3\17\0F-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1<Ä-\1\1\0\15\0\1\0X\2\tÄ-\1\1\0009\1\2\1B\1\1\2\15\0\1\0X\2\4Ä-\1\1\0009\1\3\1B\1\1\1X\0010Ä6\1\4\0009\1\5\0019\1\6\1\15\0\1\0X\2\22Ä6\1\a\0'\3\5\0B\1\2\0029\2\b\1B\2\1\2\15\0\2\0X\3$Ä6\2\t\0009\2\n\0029\2\v\0026\4\t\0009\4\n\0049\4\f\4'\6\r\0+\a\2\0+\b\2\0+\t\2\0B\4\5\2'\5\14\0+\6\2\0B\2\4\1X\1\21Ä-\1\2\0B\1\1\2\15\0\1\0X\2\15Ä6\1\t\0009\1\n\0019\1\v\0016\3\t\0009\3\n\0039\3\f\3'\5\15\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\16\0+\5\2\0B\1\4\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\2¿\0\0\6n\n<tab>\5/<cmd>lua require('neogen').jump_next()<CR>\27nvim_replace_termcodes\18nvim_feedkeys\bapi\bvim\rjumpable\frequire\vloaded\vneogen\19packer_plugins\19expand_or_jump\23expand_or_jumpable\21select_next_item\fvisibleg\0\1\3\1\5\1\0156\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\5Ä-\1\0\0009\1\3\1B\1\1\2\14\0\1\0X\2\3Ä-\1\0\0009\1\4\1B\1\1\2L\1\2\0\0¿\rcomplete\nclose\15pumvisible\afn\bvim\2ü\b\1\0\f\1>\0u6\0\0\0009\0\1\0009\0\2\0\14\0\0\0X\0\4Ä6\0\3\0009\0\4\0'\2\5\0B\0\2\0016\0\6\0'\2\a\0B\0\2\0026\1\6\0'\3\b\0B\1\2\0026\2\6\0'\4\t\0B\2\2\0026\3\6\0'\5\n\0B\3\2\0029\3\v\3B\3\1\0019\3\f\0005\5\16\0005\6\14\0003\a\r\0=\a\15\6=\6\17\0055\6\19\0003\a\18\0=\a\20\6=\6\21\0055\6\22\0=\6\23\0055\6\24\0=\6\25\0055\6\29\0009\a\26\0003\t\27\0005\n\28\0B\a\3\2=\a\30\0069\a\26\0003\t\31\0005\n \0B\a\3\2=\a!\0069\a\26\0009\a\"\a)\t¸ˇB\a\2\2=\a#\0069\a\26\0009\a\"\a)\t\4\0B\a\2\2=\a$\0069\a\26\0003\t%\0B\a\2\2=\a&\0069\a\26\0009\a'\aB\a\1\2=\a(\0069\a\26\0009\a)\a5\t*\0B\a\2\2=\a+\6=\6\26\0054\6\4\0005\a,\0>\a\1\0065\a-\0>\a\2\0065\a.\0>\a\3\6=\6/\5B\3\2\0019\3\f\0009\0030\3'\0051\0005\0063\0004\a\3\0005\b2\0>\b\1\a=\a/\6B\3\3\0019\3\f\0009\0030\3'\0054\0005\0068\0009\a5\0009\a/\a4\t\3\0005\n6\0>\n\1\t4\n\3\0005\v7\0>\v\1\nB\a\3\2=\a/\6B\3\3\0016\3\6\0'\0059\0B\3\2\0029\4:\0\18\6\4\0009\4;\4'\a<\0009\b=\3B\b\1\0A\4\2\0012\0\0ÄK\0\1\0\1¿\20on_confirm_done\17confirm_done\aon\nevent\"nvim-autopairs.completion.cmp\1\0\0\1\0\1\tname\fcmdline\1\0\1\tname\tpath\vconfig\6:\1\0\0\1\0\1\tname\vbuffer\6/\fcmdline\fsources\1\0\1\tname\tpath\1\0\1\tname\fluasnip\1\0\1\tname\rnvim_lsp\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\nclose\14<C-Space>\0\n<C-f>\n<C-d>\16scroll_docs\n<Tab>\1\4\0\0\6i\6s\6c\0\f<S-Tab>\1\0\0\1\4\0\0\6i\6s\6c\0\fmapping\17experimental\1\0\1\15ghost_text\2\15completion\1\0\2\16completeopt#menu,menuone,noselect,noinsert\19keyword_length\3\1\fsnippet\vexpand\1\0\0\0\15formatting\1\0\0\vformat\1\0\0\0\nsetup\tinit\24plugins.cmp.luasnip\fluasnip\flspkind\bcmp\frequire\25packadd plenary.nvim\bcmd\bvim\vloaded\17plenary.nvim\19packer_plugins\0" },
    loaded = true,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n¥\1\0\0\n\0\b\0\0215\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\1B\1\1\0016\1\4\0\18\3\0\0B\1\2\4X\4\bÄ5\6\6\0'\a\5\0\18\b\5\0&\a\b\a=\a\a\0066\a\1\0009\t\a\6B\a\2\1E\4\3\3R\4ˆK\0\1\0\15lsp_config\1\0\0\23plugins.lspconfig.\vipairs\tinit\22plugins.lspStatus\frequire\1\4\0\0\bcss\veslint\ats\0" },
    loaded = true,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    commands = { "NvimTreeToggle", "NvimTreeFindFile" },
    config = { "\27LJ\2\næ\4\0\0\6\0\25\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0025\3\5\0=\3\6\0025\3\a\0005\4\b\0=\4\t\3=\3\n\0025\3\v\0004\4\0\0=\4\f\3=\3\r\0025\3\14\0004\4\0\0=\4\15\3=\3\16\0025\3\17\0005\4\18\0004\5\0\0=\5\19\4=\4\20\3=\3\21\0025\3\22\0004\4\0\0=\4\23\3=\3\24\2B\0\2\1K\0\1\0\ffilters\vcustom\1\0\1\rdotfiles\1\tview\rmappings\tlist\1\0\1\16custom_only\1\1\0\4\tside\tleft\nwidth\3\30\16auto_resize\1\vheight\3\30\16system_open\targs\1\0\0\24update_focused_file\16ignore_list\1\0\2\venable\1\15update_cwd\1\16diagnostics\nicons\1\0\4\tinfo\bÔÅö\thint\bÔÅ™\nerror\bÔÅó\fwarning\bÔÅ±\1\0\1\venable\1\22update_to_buf_dir\1\0\2\venable\2\14auto_open\2\23ignore_ft_on_setup\1\0\a\18open_on_setup\1\17hijack_netrw\2\18disable_netrw\2\15update_cwd\1\18hijack_cursor\1\16open_on_tab\1\15auto_close\1\nsetup\14nvim-tree\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-autotag"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/opt/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["orgmode.nvim"] = {
    config = { "\27LJ\2\nâ\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\21org_agenda_files\1\0\1\27org_default_notes_file\21~/org/refile.org\1\2\0\0\f~/org/*\nsetup\forgmode\frequire\0" },
    keys = { { "", "<space>oc" }, { "", "<space>oa" } },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/opt/orgmode.nvim",
    url = "https://github.com/kristijanhusak/orgmode.nvim",
    wants = { "nvim-cmp" }
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/opt/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/opt/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-project.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/opt/telescope-project.nvim",
    url = "https://github.com/nvim-telescope/telescope-project.nvim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    config = { "\27LJ\2\n/\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\16:normal! zx\bcmd\bvimM\1\1\6\1\5\0\v-\1\0\0009\1\0\1\18\3\1\0009\1\1\0015\4\3\0003\5\2\0=\5\4\4B\1\3\1+\1\2\0002\0\0ÄL\1\2\0\1¿\tpost\1\0\0\0\fenhance\vselectØ\t\1\0\t\0.\0N6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\5\0'\2\6\0B\0\2\0026\1\5\0'\3\a\0B\1\2\0029\2\b\0005\4\14\0005\5\f\0005\6\t\0003\a\n\0=\a\v\6=\6\r\5=\5\15\0045\5\16\0005\6\18\0005\a\17\0=\a\19\6=\6\20\0056\6\5\0'\b\21\0B\6\2\0029\6\22\6=\6\23\0055\6\24\0=\6\25\0056\6\5\0'\b\21\0B\6\2\0029\6\26\6=\6\27\0055\6\28\0=\6\29\0056\6\5\0'\b\30\0B\6\2\0029\6\31\0069\6 \6=\6!\0056\6\5\0'\b\30\0B\6\2\0029\6\"\0069\6 \6=\6#\0056\6\5\0'\b\30\0B\6\2\0029\6$\0069\6 \6=\6%\0056\6\5\0'\b\30\0B\6\2\0029\6&\6=\6&\5=\5'\0045\5)\0005\6(\0=\6*\0055\6+\0=\6,\5=\5-\4B\2\2\0012\0\0ÄK\0\1\0\15extensions\fproject\1\0\2\14max_depth\3\4\17hidden_files\2\bfzf\1\0\0\1\0\4\nfuzzy\2\14case_mode\15smart_case\25override_file_sorter\2\28override_generic_sorter\2\rdefaults\27buffer_previewer_maker\21qflist_previewer\22vim_buffer_qflist\19grep_previewer\23vim_buffer_vimgrep\19file_previewer\bnew\19vim_buffer_cat\25telescope.previewers\fset_env\1\0\1\14COLORTERM\14truecolor\19generic_sorter\29get_generic_fuzzy_sorter\25file_ignore_patterns\1\3\0\0\n.git/\17node_modules\16file_sorter\23get_generic_sorter\22telescope.sorters\18layout_config\rvertical\1\0\0\1\0\1\nwidth\4\0ÄÄÄˇ\3\1\0\n\ruse_less\2\19color_devicons\2\20layout_strategy\15horizontal\21sorting_strategy\15descending\23selection_strategy\nreset\17initial_mode\vinsert\17entry_prefix\a  \20selection_caret\a> \18prompt_prefix\a> \rwinblend\3\0\fpickers\1\0\0\15find_files\1\0\0\20attach_mappings\0\1\0\1\vhidden\2\nsetup\26telescope.actions.set\14telescope\frequire&packadd telescope-fzf-native.nvim#packadd telescope-project.nvim\25packadd plenary.nvim\bcmd\bvim\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/villadsvalur/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: lspkind-nvim
time([[Config for lspkind-nvim]], true)
try_loadstring("\27LJ\2\në\3\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\15symbol_map\1\0\25\rConstant\bÔ£æ\fSnippet\bÔëè\vStruct\bÔ≠Ñ\fKeyword\bÔ†ä\nEvent\bÔÉß\tEnum\bÔÖù\rOperator\bÔöî\nValue\bÔ¢ü\18TypeParameter\5\tUnit\bÔ•¨\rProperty\bÔ∞†\vModule\bÔíá\14Interface\bÔÉ®\nClass\bÔ¥Ø\rVariable\bÔî™\nField\bÔ∞†\16Constructor\bÔê£\15EnumMember\bÔÖù\rFunction\bÔûî\vFolder\bÔùä\vMethod\bÔö¶\14Reference\bÔúÜ\tText\bÔùæ\tFile\bÔúò\nColor\bÔ£ó\1\0\2\14with_text\2\vpreset\rcodicons\tinit\flspkind\frequire\0", "config", "lspkind-nvim")
time([[Config for lspkind-nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\n¥\1\0\0\n\0\b\0\0215\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\1B\1\1\0016\1\4\0\18\3\0\0B\1\2\4X\4\bÄ5\6\6\0'\a\5\0\18\b\5\0&\a\b\a=\a\a\0066\a\1\0009\t\a\6B\a\2\1E\4\3\3R\4ˆK\0\1\0\15lsp_config\1\0\0\23plugins.lspconfig.\vipairs\tinit\22plugins.lspStatus\frequire\1\4\0\0\bcss\veslint\ats\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: lsp-colors.nvim
time([[Config for lsp-colors.nvim]], true)
try_loadstring("\27LJ\2\n~\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\4\16Information\f#0db9d7\fWarning\f#e0af68\tHint\f#10B981\nError\f#db4b4b\nsetup\15lsp-colors\frequire\0", "config", "lsp-colors.nvim")
time([[Config for lsp-colors.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n¨\1\0\2\5\1\b\0\15-\2\0\0009\2\1\0029\2\2\0029\3\0\0018\2\3\2'\3\3\0009\4\0\1&\2\4\2=\2\0\0015\2\5\0009\3\6\0009\3\a\0038\2\3\2=\2\4\1L\1\2\0\1¿\tname\vsource\1\0\4\rnvim_lua\n[Lua]\rnvim_lsp\n[LSP]\fluasnip\14[LuaSnip]\tpath\v[Path]\tmenu\6 \fdefault\fpresets\tkindC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequireü\2\0\1\t\3\n\0--\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1#Ä-\1\1\0\15\0\1\0X\2\vÄ-\1\1\0009\1\2\1)\3ˇˇB\1\2\2\15\0\1\0X\2\5Ä-\1\1\0009\1\3\1)\3ˇˇB\1\2\1X\1\21Ä-\1\2\0B\1\1\2\15\0\1\0X\2\15Ä6\1\4\0009\1\5\0019\1\6\0016\3\4\0009\3\5\0039\3\a\3'\5\b\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\t\0+\5\2\0B\1\4\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\2¿\0\0\6n\f<s-tab>\27nvim_replace_termcodes\18nvim_feedkeys\bapi\bvim\tjump\rjumpable\21select_prev_item\fvisibleÔ\3\0\1\n\3\17\0F-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1<Ä-\1\1\0\15\0\1\0X\2\tÄ-\1\1\0009\1\2\1B\1\1\2\15\0\1\0X\2\4Ä-\1\1\0009\1\3\1B\1\1\1X\0010Ä6\1\4\0009\1\5\0019\1\6\1\15\0\1\0X\2\22Ä6\1\a\0'\3\5\0B\1\2\0029\2\b\1B\2\1\2\15\0\2\0X\3$Ä6\2\t\0009\2\n\0029\2\v\0026\4\t\0009\4\n\0049\4\f\4'\6\r\0+\a\2\0+\b\2\0+\t\2\0B\4\5\2'\5\14\0+\6\2\0B\2\4\1X\1\21Ä-\1\2\0B\1\1\2\15\0\1\0X\2\15Ä6\1\t\0009\1\n\0019\1\v\0016\3\t\0009\3\n\0039\3\f\3'\5\15\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\16\0+\5\2\0B\1\4\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\2¿\0\0\6n\n<tab>\5/<cmd>lua require('neogen').jump_next()<CR>\27nvim_replace_termcodes\18nvim_feedkeys\bapi\bvim\rjumpable\frequire\vloaded\vneogen\19packer_plugins\19expand_or_jump\23expand_or_jumpable\21select_next_item\fvisibleg\0\1\3\1\5\1\0156\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\5Ä-\1\0\0009\1\3\1B\1\1\2\14\0\1\0X\2\3Ä-\1\0\0009\1\4\1B\1\1\2L\1\2\0\0¿\rcomplete\nclose\15pumvisible\afn\bvim\2ü\b\1\0\f\1>\0u6\0\0\0009\0\1\0009\0\2\0\14\0\0\0X\0\4Ä6\0\3\0009\0\4\0'\2\5\0B\0\2\0016\0\6\0'\2\a\0B\0\2\0026\1\6\0'\3\b\0B\1\2\0026\2\6\0'\4\t\0B\2\2\0026\3\6\0'\5\n\0B\3\2\0029\3\v\3B\3\1\0019\3\f\0005\5\16\0005\6\14\0003\a\r\0=\a\15\6=\6\17\0055\6\19\0003\a\18\0=\a\20\6=\6\21\0055\6\22\0=\6\23\0055\6\24\0=\6\25\0055\6\29\0009\a\26\0003\t\27\0005\n\28\0B\a\3\2=\a\30\0069\a\26\0003\t\31\0005\n \0B\a\3\2=\a!\0069\a\26\0009\a\"\a)\t¸ˇB\a\2\2=\a#\0069\a\26\0009\a\"\a)\t\4\0B\a\2\2=\a$\0069\a\26\0003\t%\0B\a\2\2=\a&\0069\a\26\0009\a'\aB\a\1\2=\a(\0069\a\26\0009\a)\a5\t*\0B\a\2\2=\a+\6=\6\26\0054\6\4\0005\a,\0>\a\1\0065\a-\0>\a\2\0065\a.\0>\a\3\6=\6/\5B\3\2\0019\3\f\0009\0030\3'\0051\0005\0063\0004\a\3\0005\b2\0>\b\1\a=\a/\6B\3\3\0019\3\f\0009\0030\3'\0054\0005\0068\0009\a5\0009\a/\a4\t\3\0005\n6\0>\n\1\t4\n\3\0005\v7\0>\v\1\nB\a\3\2=\a/\6B\3\3\0016\3\6\0'\0059\0B\3\2\0029\4:\0\18\6\4\0009\4;\4'\a<\0009\b=\3B\b\1\0A\4\2\0012\0\0ÄK\0\1\0\1¿\20on_confirm_done\17confirm_done\aon\nevent\"nvim-autopairs.completion.cmp\1\0\0\1\0\1\tname\fcmdline\1\0\1\tname\tpath\vconfig\6:\1\0\0\1\0\1\tname\vbuffer\6/\fcmdline\fsources\1\0\1\tname\tpath\1\0\1\tname\fluasnip\1\0\1\tname\rnvim_lsp\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\nclose\14<C-Space>\0\n<C-f>\n<C-d>\16scroll_docs\n<Tab>\1\4\0\0\6i\6s\6c\0\f<S-Tab>\1\0\0\1\4\0\0\6i\6s\6c\0\fmapping\17experimental\1\0\1\15ghost_text\2\15completion\1\0\2\16completeopt#menu,menuone,noselect,noinsert\19keyword_length\3\1\fsnippet\vexpand\1\0\0\0\15formatting\1\0\0\vformat\1\0\0\0\nsetup\tinit\24plugins.cmp.luasnip\fluasnip\flspkind\bcmp\frequire\25packadd plenary.nvim\bcmd\bvim\vloaded\17plenary.nvim\19packer_plugins\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: mkdir.nvim
time([[Config for mkdir.nvim]], true)
try_loadstring("\27LJ\2\n%\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\nmkdir\frequire\0", "config", "mkdir.nvim")
time([[Config for mkdir.nvim]], false)
-- Config for: ayu-vim
time([[Config for ayu-vim]], true)
try_loadstring("\27LJ\2\nw\0\0\3\0\t\0\r6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\4\0'\1\6\0=\1\5\0006\0\0\0009\0\a\0'\2\b\0B\0\2\1K\0\1\0\20colorscheme ayu\bcmd\vmirage\rayucolor\6g\tdark\15background\6o\bvim\0", "config", "ayu-vim")
time([[Config for ayu-vim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NvimTreeToggle lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NvimTreeFindFile lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeFindFile", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> <space>oc <cmd>lua require("packer.load")({'orgmode.nvim'}, { keys = "<lt>space>oc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <space>oa <cmd>lua require("packer.load")({'orgmode.nvim'}, { keys = "<lt>space>oa", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType javascriptreact ++once lua require("packer.load")({'nvim-colorizer.lua', 'nvim-ts-autotag'}, { ft = "javascriptreact" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescriptreact ++once lua require("packer.load")({'nvim-colorizer.lua', 'nvim-ts-autotag'}, { ft = "typescriptreact" }, _G.packer_plugins)]]
vim.cmd [[au FileType org ++once lua require("packer.load")({'orgmode.nvim'}, { ft = "org" }, _G.packer_plugins)]]
vim.cmd [[au FileType lua ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'nvim-ts-autotag'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "css" }, _G.packer_plugins)]]
vim.cmd [[au FileType scss ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "scss" }, _G.packer_plugins)]]
vim.cmd [[au FileType sass ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "sass" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/villadsvalur/.local/share/nvim/site/pack/packer/opt/orgmode.nvim/ftdetect/org.vim]], true)
vim.cmd [[source /Users/villadsvalur/.local/share/nvim/site/pack/packer/opt/orgmode.nvim/ftdetect/org.vim]]
time([[Sourcing ftdetect script at: /Users/villadsvalur/.local/share/nvim/site/pack/packer/opt/orgmode.nvim/ftdetect/org.vim]], false)
time([[Sourcing ftdetect script at: /Users/villadsvalur/.local/share/nvim/site/pack/packer/opt/orgmode.nvim/ftdetect/org_archive.vim]], true)
vim.cmd [[source /Users/villadsvalur/.local/share/nvim/site/pack/packer/opt/orgmode.nvim/ftdetect/org_archive.vim]]
time([[Sourcing ftdetect script at: /Users/villadsvalur/.local/share/nvim/site/pack/packer/opt/orgmode.nvim/ftdetect/org_archive.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
