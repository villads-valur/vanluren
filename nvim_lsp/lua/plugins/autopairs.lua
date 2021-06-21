local npairs = require("nvim-autopairs")

npairs.setup({
    check_ts = true,
    ignored_next_char = "[%w%.]",
    check_line_pair = false,
})

_G.global.on_enter = function()
    return npairs.autopairs_cr()
end

vim.api.nvim_set_keymap("i", "<CR>", "v:lua.global.on_enter()", { expr = true })
