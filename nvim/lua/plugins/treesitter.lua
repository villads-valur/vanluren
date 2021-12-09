require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
    ensure_installed = {
        "bash",
        "hjson",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "python",
        "toml",
        "tsx",
        "typescript",
        "yaml",
    },
    -- plugins
    autopairs = { enable = true },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    textsubjects = {
        enable = true,
        keymaps = {
            ["."] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer",
        },
    },
    autotag = {
        enable = true,
    },
})
