local autocmd = vim.api.nvim_create_autocmd
local cmd = vim.api.nvim_create_user_command

-- Create parent directories when saving a file.
autocmd("BufWritePre", {
  desc = "Automatically create parent directories if they don't exist when saving a file",
  callback = function(args)
    local buf_is_valid_and_listed = vim.api.nvim_buf_is_valid(args.buf)
        and vim.bo[args.buf].buflisted

    if buf_is_valid_and_listed then
      vim.fn.mkdir(vim.fn.fnamemodify(
        vim.loop.fs_realpath(args.match) or args.match, ":p:h"), "p")
    end
  end,
})

-- Close all notifications on BufWritePre.
autocmd("BufWritePre", {
  desc = "Close all notifications on BufWritePre",
  callback = function()
    require("notify").dismiss({ pending = true, silent = true })
  end,
})

-- Close all notifications
cmd("CloseNotifications", function()
  require("notify").dismiss({ pending = true, silent = true })
end, { desc = "Dismiss all notifications" })

-- Change working directory
cmd("Cwd", function()
  vim.cmd ":cd %:p:h"
  vim.cmd ":pwd"
end, { desc = "cd current file's directory" })

-- Set working directory (alias)
cmd("Swd", function()
  vim.cmd ":cd %:p:h"
  vim.cmd ":pwd"
end, { desc = "cd current file's directory" })

-- Write all buffers
cmd("WriteAllBuffers", function()
  vim.cmd "wa"
end, { desc = "Write all changed buffers" })
