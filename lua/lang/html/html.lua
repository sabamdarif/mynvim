return {
    lsp_servers = { "html", "emmet_ls" },

    lsp_config = {
        html = {
            filetypes = { "html", "htmldjango" },
        },
        emmet_ls = {
            filetypes = {
                "html",
                "htmldjango",
                "css",
                "scss",
                "less",
                "javascriptreact",
                "typescriptreact",
            },
            -- Emmet's jsx profile leaves output.selfClosingStyle at "html", so
            -- void tags expand unclosed: `inp` -> `<input type="text">`. xhtml
            -- makes it `<input type="text" />`, which is what JSX needs.
            init_options = {
                jsx = {
                    options = {
                        ["output.selfClosingStyle"] = "xhtml",
                    },
                },
            },
        },
    },

    formatters = {
        html = { "prettier" },
    },

    mason_packages = {
        "html-lsp",
        "emmet-ls",
        "prettier",
    },

    treesitter = { "html" },
}
