return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				globalstatus = true,
				icons_enabled = true,
				theme = "auto",
				component_separators = "",
				section_separators = "",
				disabled_filetypes = { "alpha", "packer" },
				always_divide_middle = true,
				extensions = { "nvim-tree" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "filetype" },
				lualine_y = { "location" },
				lualine_z = { 'os.date("%I:%M", os.time())' },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		})

		-- Turn off lualine inside nvim-tree
		vim.cmd([[
  au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
]])

		-- Trigger rerender of status line every minute for clock
		if _G.Statusline_timer == nil then
			_G.Statusline_timer = vim.loop.new_timer()
		else
			_G.Statusline_timer:stop()
		end
		_G.Statusline_timer:start(
			0,
			60000,
			vim.schedule_wrap(function()
				vim.api.nvim_command("redrawstatus")
			end)
		)
	end,
}
