return {
    lsp_servers = { "ts_ls" },

    lsp_config = {
        ts_ls = {
            settings = {
                typescript = {
                    inlayHints = {
                        includeInlayParameterNameHints = "all",
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                    },
                },
                javascript = {
                    inlayHints = {
                        includeInlayParameterNameHints = "all",
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
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

    treesitter = { "javascript", "typescript", "tsx", "jsdoc" },
}
