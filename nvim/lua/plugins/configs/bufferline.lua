local map = require("utils").map

require("bufferline").setup({
	options = {
		offsets = {
			{
				filetype = "NvimTree",
				text = function()
					return vim.fn.getcwd()
				end,
				highlight = "Directory",
				text_align = "left",
			},
		},
		buffer_close_icon = "",
		modified_icon = "",
		close_icon = "",
		show_close_icon = true,
		left_trunc_marker = "",
		right_trunc_marker = "",
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
	},
	highlights = {
		fill = {
			bg = { attribute = "bg", highlight = "Normal" },
		},
		background = {
			bg = { attribute = "bg", highlight = "Normal" },
		},
		buffer = {
			fg = { attribute = "fg", highlight = "NonText" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		buffer_visible = {
			fg = { attribute = "fg", highlight = "NonText" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		buffer_selected = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
			underline = false,
			undercurl = false,
			italic = false,
		},
		modified = {
			fg = { attribute = "fg", highlight = "NonText" },
			bg = { attribute = "bg", highlight = "NonText" },
		},
		modified_visible = {
			fg = { attribute = "fg", highlight = "NonText" },
			bg = { attribute = "bg", highlight = "NonText" },
		},
		modified_selected = {
			fg = { attribute = "fg", highlight = "Normal" },
			underline = false,
			undercurl = false,
			italic = false,
		},
		duplicate = {
			fg = { attribute = "fg", highlight = "NonText" },
			bg = { attribute = "bg", highlight = "NonText" },
		},
		duplicate_visible = {
			bg = { attribute = "bg", highlight = "Normal" },
		},
		duplicate_selected = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		diagnostic = {
			fg = { attribute = "fg", highlight = "NonText" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		diagnostic_visible = {
			fg = { attribute = "fg", highlight = "NonText" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		diagnostic_selected = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		error = {
			fg = { attribute = "fg", highlight = "NonText" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		error_visible = {
			fg = { attribute = "fg", highlight = "NonText" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		error_selected = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		error_diagnostic = {
			fg = { attribute = "fg", highlight = "NonText" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		error_diagnostic_visible = {
			fg = { attribute = "fg", highlight = "NonText" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		error_diagnostic_selected = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		warning = {
			fg = { attribute = "fg", highlight = "NonText" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		warning_visible = {
			fg = { attribute = "fg", highlight = "NonText" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		warning_selected = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		warning_diagnostic = {
			fg = { attribute = "fg", highlight = "NonText" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		warning_diagnostic_visible = {
			fg = { attribute = "fg", highlight = "NonText" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		warning_diagnostic_selected = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		info = {
			fg = { attribute = "fg", highlight = "NonText" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		info_visible = {
			fg = { attribute = "fg", highlight = "NonText" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		info_selected = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		info_diagnostic = {
			fg = { attribute = "fg", highlight = "NonText" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		info_diagnostic_visible = {
			fg = { attribute = "fg", highlight = "NonText" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		info_diagnostic_selected = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		hint_diagnostic = {
			fg = { attribute = "fg", highlight = "NonText" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		hint_diagnostic_visible = {
			fg = { attribute = "fg", highlight = "NonText" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		hint_diagnostic_selected = {
			fg = { attribute = "fg", highlight = "Normal" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
	},
})

map("n", "<TAB>", ":BufferLineCycleNext<CR>")
map("n", "<S-TAB>", ":BufferLineCyclePrev<CR>")
