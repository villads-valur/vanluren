local keymap = vim.keymap.set
local silent = { silent = true }

-- General
keymap("n", "<Leader>w", "<cmd>w<cr>", { desc = "Write buffer" })
keymap("n", "<Leader>v", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
keymap("n", "<Leader>q", "<cmd>q<cr>", { desc = "Quit" })

---- Remove highlights
keymap("n", "<CR>", ":noh<CR><CR>", silent)
keymap("n", "<ESC><ESC>", ":noh<CR><CR>", silent)

---- Don't yank on delete char
keymap("n", "x", '"_x', silent)
keymap("n", "X", '"_X', silent)
keymap("v", "x", '"_x', silent)
keymap("v", "X", '"_X', silent)

-- Don't yank on visual paste
keymap("v", "p", '"_dP', silent)

-- Buffers
keymap("n", "<Tab>", "<CMD>bnext<CR>", silent)
keymap("n", "<S-Tab>", "<CMD>bprevious<CR>", silent)
keymap("n", "<Leader>x", "<CMD>bd<cr>", silent)
keymap("n", "<Leader>cn", "<CMD>:set rnu!<cr>", silent)
keymap("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
keymap("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- better up/down
keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
keymap({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Files
keymap("n", "<leader>ff", "<CMD>Telescope find_files<cr>", { desc = "Find File" })
keymap("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Diagnostics

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

keymap("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
keymap("n", "ln", diagnostic_goto(true), { desc = "Next Diagnostic" })
keymap("n", "lp", diagnostic_goto(false), { desc = "Prev Diagnostic" })
keymap("n", "lne", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
keymap("n", "lpe", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
keymap("n", "lnw", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
keymap("n", "lpw", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
