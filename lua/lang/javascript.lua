return {
    lsp_servers = { "ts_ls" },

    lsp_config = {
        ts_ls = {
            settings = {
                typescript = {
                    inlayHints = {
                        includeInlayParameterNameHints = "all",
                        includeInlayFunctionParameterTypeHints = true,
                    },
                },
            },
        },
    },

    formatters = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
    },

    mason_packages = {
        "typescript-language-server",
        "prettier",
    },

    treesitter = { "javascript", "typescript", "tsx" },
}
