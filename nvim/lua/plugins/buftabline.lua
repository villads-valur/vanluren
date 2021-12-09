local buftabline = require("buftabline")
local icons = require("icons")

local u = require("utils")

buftabline.setup(
  {
    tab_format = "#{i} #{b} #{f}",
    auto_hide = true,
    hlgroups = {
      current = "TabLineSel",
      normal = "TabLine",
      active = nil,
      spacing = nil,
      modified_current = nil,
      modified_normal = nil,
      modified_active = nil,
      tabpage_current = nil,
      tabpage_normal = nil
    },
    flags = {
      modified = icons.gitChange,
      not_modifiable = icons.error,
      readonly = icons.threeDots
    }
  }
)
