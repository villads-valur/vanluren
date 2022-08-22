local hop = require("hop")
local map = require("utils").map

hop.setup()

map("n", "t", ":HopAnywhere<CR>")
map("n", "T", ":HopChar1<CR>")
map("n", "l", ":HopLineStart<CR>")
map("n", "L", ":HopLine<CR>")
