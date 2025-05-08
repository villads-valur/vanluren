return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "Kaiser-Yang/blink-cmp-avante",
    },
    opts = {
      sources = {
        default = { "avante", "lsp", "path", "snippets", "buffer" },

        providers = {
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
          },
        },
      },
      build = "cargo build --release",
    },
  },
}
