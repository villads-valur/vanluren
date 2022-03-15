-- Init
require("nvim-tree").setup({})
local map = require("utils").map

-- Additional settings for the tree
local g = vim.g

g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
g.nvim_tree_git_hl = 0
g.nvim_tree_highlight_opened_files = 0
g.nvim_tree_indent_markers = 1
g.nvim_tree_quit_on_open = 0 -- closes tree when file's opened
g.nvim_tree_root_folder_modifier = table.concat({ ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" })

g.nvim_tree_window_picker_exclude = {
	filetype = { "notify", "packer", "qf" },
	buftype = { "terminal" },
}

g.nvim_tree_show_icons = {
	folders = 1,
	files = 1,
	git = 1,
}

g.nvim_tree_icons = {
	default = "",
	symlink = "",
	git = {
		deleted = "",
		ignored = "◌",
		renamed = "➜",
		staged = "✓",
		unmerged = "",
		unstaged = "✗",
		untracked = "★",
	},
	folder = {
		efault = "",
		empty = "",
		empty_open = "",
		open = "",
		symlink = "",
		symlink_open = "",
	},
}

map("n", "<Leader>n", ":NvimTreeToggle<CR>")
map("n", "<Leader>e", ":NvimTreeToggle<CR>")

map("n", "<Leader>fe", ":NvimTreeFindFile<CR>")
