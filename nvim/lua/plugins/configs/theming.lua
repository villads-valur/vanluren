local cmd = vim.cmd
local dn = require("dark_notify")

require("onedarkpro").setup({
	caching = true,
	theme = "onedark",
	colors = {
		bg = "#1F1F29",
	},
	options = {
		cursorline = false,
	},
})

local light_theme = "ayu-light"
local dark_theme = "onedarkpro"

-- DarkNotify
function nox()
	cmd("colorscheme" .. " " .. dark_theme)
	cmd("set bg=dark")
end

function lumos()
	cmd("colorscheme" .. " " .. light_theme)
	cmd("set bg=light")
end

dn.configure({
	enable = false,
	schemes = {
		dark = dark_theme,
		light = light_theme,
	},
})

dn.run()

cmd("command! Nox :lua nox()")
cmd("command! Lumos :lua lumos()")
cmd("command! StartDN :lua require('dark_notify').run()")
cmd("command! StopDN :lua require('dark_notify').stop()")
cmd("command! ToggleDN :lua require('dark_notify').toggle()")
