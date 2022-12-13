local hop = require("hop")
local map = require("utils").map

hop.setup()

map("n", "t", ":HopChar1<CR>")
map("n", "tt", ":HopChar2<CR>")
map("n", "T", ":HopAnywhere<CR>")
map("n", "l", ":HopLineStart<CR>")
map("n", "L", ":HopLine<CR>")
