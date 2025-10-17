-- Python Language Configuration
return {
    -- LSP servers to enable
    lsp_servers = { "pyright" },

    -- Formatters by filetype
    formatters = {
        python = { "ruff" },
    },

    -- Mason packages to install
    mason_packages = {
        "pyright",
        "ruff",
    },

    -- Treesitter parsers
    treesitter = { "python" },
}
