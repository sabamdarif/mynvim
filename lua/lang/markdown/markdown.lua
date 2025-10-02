-- Markdown Language Configuration
return {
    -- LSP servers to enable
    -- lsp_servers = { "marksman" },

    -- LSP server-specific configurations
    lsp_config = {
        marksman = {
            filetypes = { "markdown", "md" },
        },
    },

    -- Formatters by filetype
    formatters = {
        markdown = { "prettier" },
    },

    -- Mason packages to install
    mason_packages = {
        "prettier",
    },

    -- Treesitter parsers
    treesitter = { "markdown", "markdown_inline" },
}
