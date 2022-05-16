require("dark_notify").run({
	schemes = {
		-- you can use a different colorscheme for each
		dark = "onedark",
		-- even a different `set background=light/dark` setting or lightline theme
		-- if you use lightline, you may want to configure lightline themes,
		-- even if they're the same one, especially if the theme reacts to :set bg
		light = "ayu-light",
	},
})
