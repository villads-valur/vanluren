return {
	"goolord/alpha-nvim",
	requires = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = {

			"██╗  ██╗███████╗██╗     ██╗      ██████╗        ██╗",
			"██║  ██║██╔════╝██║     ██║     ██╔═══██╗    ██╗╚██╗",
			"███████║█████╗  ██║     ██║     ██║   ██║    ╚═╝ ██║",
			"██╔══██║██╔══╝  ██║     ██║     ██║   ██║    ██╗ ██║",
			"██║  ██║███████╗███████╗███████╗╚██████╔╝    ╚═╝██╔╝",
			"╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝ ╚═════╝        ╚═╝",
		}

		-- menu
		dashboard.section.buttons.val = {
			dashboard.button("t", " Find file", "<CMD>Telescope find_files<CR>"),
			dashboard.button("r", " Recent Files", "<CMD>Telescope oldfiles<CR>"),
			dashboard.button("s", " Settings", ":e $MYVIMRC<CR>"),
			dashboard.button("u", " Update plugins", "<CMD>Lazy update<CR>"),
			dashboard.button("q", " Quit", "<CMD>qa<CR>"),
		}

		require("alpha").setup(dashboard.config)
	end,
}
