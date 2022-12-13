local map = require("utils").map

local saga = require("lspsaga")

saga.init_lsp_saga({
	debug = false,
	use_saga_diagnostic_sign = false,
	-- Code actions
	code_action_icon = "",
	code_action_prompt = {
		enable = true,
		sign = true,
		sign_priority = 40,
		virtual_text = false,
	},
	finder_definition_icon = "  ",
	finder_reference_icon = "  ",
	max_preview_lines = 10,
	finder_action_keys = {
		open = "<CR>",
		vsplit = "v",
		hsplit = "h",
		quit = "q",
		scroll_down = "<C-f>",
		scroll_up = "<C-b>",
	},
	code_action_keys = {
		quit = "q",
		exec = "<CR>",
	},
	rename_action_keys = {
		quit = "<C-c>",
		exec = "<CR>",
	},
	definition_preview_icon = "  ",
	border_style = "round",
	rename_prompt_prefix = "➤ ",
	server_filetype_map = {},
	diagnostic_prefix_format = "%d. ",
})

map("n", "<Leader>ca", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>")
map("v", "<Leader>ca", ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>")
map("n", "<Leader>rn", "<cmd>lua require('lspsaga.rename').rename()<CR>")

map("n", "gh", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>")
map("n", "gd", "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>")
map("n", "gf", "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>")
map("n", "gs", "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>")

map("n", "lp", ":LspDiagPrev<CR>")
map("n", "ln", ":LspDiagNext<CR>")
