vim.loader.enable()
for _, source in ipairs {
  "config.options",
  "config.keymaps",
  "config.autocmds",
  "config.lazy"
} do
  local status_ok, error = pcall(require, source)
  if not status_ok then vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. error) end
end

if base.default_colorscheme then
  if not pcall(vim.cmd.colorscheme, base.default_colorscheme) then
    require("base.utils").notify(
      "Error setting up colorscheme: " .. base.default_colorscheme,
      vim.log.levels.ERROR
    )
  end
end
