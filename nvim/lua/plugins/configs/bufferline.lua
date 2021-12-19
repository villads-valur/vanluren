local bufferline = require("bufferline")

bufferline.setup({
	offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
	show_close_icon = true,
	max_name_length = 14,
	max_prefix_length = 13,
	tab_size = 20,
	show_tab_indicators = true,
	enforce_regular_tabs = false,
	view = "multiwindow",
	show_buffer_close_icons = true,
	separator_style = "thin",
	always_show_bufferline = true,
	diagnostics = false,
	tab_format = "#{i} #{b} #{f}",
	autohide = true,
})
