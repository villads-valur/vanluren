local cmd = vim.cmd
local dn = require("dark_notify")
local nightfox = require("nightfox")
local github = require("github-theme")
local onedarkpro = require("onedarkpro")

local light_theme = "ayu-light"
local dark_theme = "onedarkpro"

nightfox.setup({
	dim_inactive = true,
})


onedarkpro.setup({
	theme = "onedark",
	colors = { onedark = {
		bg = "#1F1F28",
	} },
})

github.setup({
	dark_float = true,
})

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
	schemes = {
		dark = dark_theme,
		light = light_theme,
	},
})

dn.run()

cmd("command! Nox :lua nox()")
cmd("command! Lumos :lua lumos()")
cmd("command! ToggleDN :lua require('dark_notify').toggle()")
