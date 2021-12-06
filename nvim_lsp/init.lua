-- Require all the files you need!

require("settings") -- lua/settings.lua

-- Global object for storing stuff in
-- Very bad idea to delete
global = {}

require("mappings") -- lua/mappings.lua
require("utils") -- lua/utils.lua
require("plugins") -- lua/plugins/init.lua
require("lsp.config") -- lua/lsp/init.lua
