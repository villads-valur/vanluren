return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	opts = function()
		local dashboard = require("alpha.themes.dashboard")

		local logo = [[
			██╗  ██╗███████╗██╗     ██╗      ██████╗        ██╗
			██║  ██║██╔════╝██║     ██║     ██╔═══██╗    ██╗╚██╗
			███████║█████╗  ██║     ██║     ██║   ██║    ╚═╝ ██║
			██╔══██║██╔══╝  ██║     ██║     ██║   ██║    ██╗ ██║
			██║  ██║███████╗███████╗███████╗╚██████╔╝    ╚═╝██╔╝
			╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝ ╚═════╝        ╚═╝
    ]]

		dashboard.section.header.val = vim.split(logo, "\n")
		dashboard.section.buttons.val = {
			dashboard.button("f", " " .. " Find file", "<CMD>Telescope find_files <CR>"),
			dashboard.button("r", " " .. " Recent files", "<CMD>Telescope oldfiles <CR>"),
			dashboard.button("u", " " .. " Update plugins", "<CMD>Lazy update<CR>"),
			dashboard.button("q", " " .. " Quit", "<CMD>qa<CR>"),
		}

		for _, button in ipairs(dashboard.section.buttons.val) do
			button.opts.hl = "Type"
			button.opts.hl_shortcut = "Type"
		end

		dashboard.section.header.opts.hl = "Function"
		dashboard.section.buttons.opts.hl = "Type"
		dashboard.section.footer.opts.hl = "FloatBorder"
		-- Vertical margins
		dashboard.config.layout[1].val = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.10) }) -- Above header
		dashboard.config.layout[3].val = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.10) }) -- Above buttons

		-- Disable autocmd and return
		dashboard.config.opts.noautocmd = true
		return dashboard
	end,
	config = function(_, opts)
		-- Footer
		require("alpha").setup(opts.config)
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
			desc = "Add Alpha dashboard footer",
			once = true,
			callback = function()
				local stats = require("lazy").stats()
				stats.real_cputime = not is_windows
				local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
				opts.section.footer.val = {
					" ",
					" ",
					" ",
					"Loaded " .. stats.loaded .. " plugins  in " .. ms .. "ms",
					".............................",
				}
				opts.section.footer.opts.hl = "DashboardFooter"
				vim.cmd("highlight DashboardFooter guifg=#D29B68")
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end,
}
