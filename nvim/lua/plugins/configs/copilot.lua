vim.cmd('imap <silent><script><expr> <C-J> copilot#Accept("<CR>")')
vim.cmd('imap <silent><script><expr> <Leader>j copilot#Accept("<CR>")')

-- Language: lua
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
