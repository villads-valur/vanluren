return {
  "cormacrelf/dark-notify",
  priority = 900,
  config = function()
    local dark_notify = require("dark_notify")
    dark_notify.run({
      schemes = {
        dark = "one-half-dark",
        light = {
          colorscheme = "ayu-light",
        },
      },
    })
  end,
}
