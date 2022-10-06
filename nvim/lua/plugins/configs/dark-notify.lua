local cmd = vim.cmd
local dn = require("dark_notify")
local onedark = require("onedark")

onedark.setup({
	style = "cool",
})

-- DarkNotify

function nox()
	cmd("colorscheme tokyodark")
	cmd("set bg=dark")
end

function lumos()
	cmd("colorscheme ayu-light")
	cmd("set bg=light")
end

dn.configure({
	schemes = {
		dark = "tokyodark",
		light = "ayu-light",
	},
})

dn.run()

cmd("command! Nox :lua nox()")
cmd("command! Lumos :lua lumos()")
cmd("command! ToggleDN :lua require('dark_notify').toggle()")
