-- Dashboard configuration file

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- setup footer
local function footer()
	local datetime = os.date("%Y/%m/%d %H:%M:%S")
	return datetime
end

-- header
dashboard.section.header.val = {
	"                                                    ",
	" ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
	" ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
	" ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
	" ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
	" ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
	" ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
	"                                                    ",
}

-- menu
dashboard.section.buttons.val = {
	dashboard.button("f", " Find file", ":Telescope find_files<CR>"),
	dashboard.button("r", " Recent Files", ":Telescope oldfiles<CR>"),
	dashboard.button("s", " Settings", ":e $MYVIMRC<CR>"),
	dashboard.button("p", " Packer Settings", ":e $MYVIMRC/lua/plugins/packer<CR>"),
	dashboard.button("u", " Update plugins", ":PackerUpdate<CR>"),
	dashboard.button("q", " Quit", ":qa<CR>"),
}

dashboard.section.footer.val = footer()

alpha.setup(dashboard.config)
