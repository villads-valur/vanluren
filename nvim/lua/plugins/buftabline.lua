local present, bufferline = pcall(require, "buffertabline")
local icons = require("icons")

if not present then
  return
end

bufferline.setup {
  options = {
    offsets = {{filetype = "NvimTree", text = "", padding = 1}},
    buffer_close_icon = icons.close_icon,
    modified_icon = icons.modified_icon,
    close_icon = icons.close_icon,
    show_close_icon = true,
    left_trunc_marker = icons.arrow_left_circle,
    right_trunc_marker = icons.arrow_right_circle,
    max_name_length = 14,
    max_prefix_length = 13,
    tab_size = 20,
    show_tab_indicators = true,
    enforce_regular_tabs = false,
    view = "multiwindow",
    show_buffer_close_icons = true,
    separator_style = "thin",
    always_show_bufferline = true,
    diagnostics = false,
    tab_format = "#{i} #{b} #{f}"
  }
}
