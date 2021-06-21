local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

-- General
map("n", "<Leader>w", [[ <Cmd> :w <CR>]], opt)
map("n", "<Leader>q", [[ <Cmd> :q <CR>]], opt)
-- Split
map("n", "<Leader>v", [[ <Cmd> :vnew <CR>]], opt)




-- dont copy any deleted text , this is disabled by default so uncomment the below mappings if you want them!
map("v", "x", [=[ "_x ]=], opt)
