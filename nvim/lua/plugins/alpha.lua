local icons = require("lazyvim.config").icons
return {
  "goolord/alpha-nvim",
  opts = function()
    local dashboard = require("alpha.themes.dashboard")

    local logo = [[
			██╗  ██╗███████╗██╗     ██╗      ██████╗        ██╗
			██║  ██║██╔════╝██║     ██║     ██╔═══██╗    ██╗╚██╗
			███████║█████╗  ██║     ██║     ██║   ██║    ╚═╝ ██║
			██╔══██║██╔══╝  ██║     ██║     ██║   ██║    ██╗ ██║
			██║  ██║███████╗███████╗███████╗╚██████╔╝    ╚═╝██╔╝
			╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝ ╚═════╝        ╚═╝
    ]]

    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
      dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("u", " " .. " Update plugins", "<CMD>Lazy update<CR>"),
      dashboard.button("q", " " .. " Quit", ":qa<CR>"),
    }

    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "Type"
      button.opts.hl_shortcut = "Type"
    end

    dashboard.section.header.opts.hl = "Function"
    dashboard.section.buttons.opts.hl = "Type"
    dashboard.section.footer.opts.hl = "FloatBorder"
    dashboard.opts.layout[1].val = 8
    return dashboard
  end,
}
