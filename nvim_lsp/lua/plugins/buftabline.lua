local buftabline = require("buftabline")

local u = require("utils")

buftabline.setup(
  {
    flags = {
      modified = " [+]",
      not_modifiable = " [-]",
      readonly = " [RO]"
    }
  }
)
