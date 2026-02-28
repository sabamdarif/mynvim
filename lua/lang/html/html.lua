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
