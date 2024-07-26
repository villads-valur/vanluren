return {
	"rcarriga/nvim-notify",
	event = "BufRead",
	config = function()
		vim.notify = require("notify")
		vim.notify.setup({
			stages = "fade_in_slide_out",
			timeout = 5000,
			render = "simple",
		})
	end,
}
