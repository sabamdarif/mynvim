return {
    lsp_servers = { "marksman" },

    lsp_config = {
        marksman = {
            filetypes = { "markdown", "md" },
        },
    },

    formatters = {
        markdown = { "prettier" },
    },

    mason_packages = {
        "marksman",
        "prettier",
    },

    treesitter = { "markdown", "markdown_inline" },
}
