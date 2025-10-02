return {
    lsp_servers = { "html" },

    lsp_config = {
        html = {
            filetypes = { "html", "htmldjango" },
        },
    },

    formatters = {
        html = { "prettier" },
    },

    mason_packages = {
        "html-lsp",
        "prettier",
    },

    treesitter = { "html" },
}
