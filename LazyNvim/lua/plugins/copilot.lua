return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      server_opts_overrides = {
        cmd_env = {
          NODE_OPTIONS = "--experimental-sqlite",
        },
      },
    },
  },
}
