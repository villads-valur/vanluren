-- function format_prettier()
--   return {
--     exe = "npx",
--     args = {"prettier", "--stdin-filepath", vim.api.nvim_buf_get_name(0)},
--     stdin = true
--   }
-- end

function format_prettier()
  return {
    exe = "prettierd",
    args = {vim.api.nvim_buf_get_name(0)},
    stdin = true
  }
end

require("formatter").setup(
  {
    filetype = {
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      },
      javascript = {format_prettier},
      typescript = {format_prettier},
      typescriptreact = {format_prettier},
      less = {format_prettier},
      css = {format_prettier},
      scss = {format_prettier}
    }
  }
)

vim.api.nvim_exec(
  [[
	augroup FormatAutogroup
	  autocmd!
	  autocmd BufWritePost *.tsx,*.ts,*.js,*.jsx,*.less,*.css,*.lua FormatWrite
	augroup END
]],
  true
)
