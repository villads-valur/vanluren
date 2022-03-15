local map = require("utils").map

map("n", "<Leader>ca", ":CodeActionMenu<CR>")

vim.g.code_action_menu_show_details = false
vim.g.code_action_menu_show_diff = false

