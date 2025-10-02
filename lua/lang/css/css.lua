return {
    lsp_servers = { "cssls" },

    lsp_config = {
        cssls = {
            settings = {
                css = {
                    validate = true,
                    lint = {
                        unknownAtRules = "ignore",
                    },
                },
                scss = {
                    validate = true,
                },
                less = {
                    validate = true,
                },
            },
        },
    },

    formatters = {
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
    },

    mason_packages = {
        "css-lsp",
        "prettier",
    },

    treesitter = { "css", "scss" },
}
