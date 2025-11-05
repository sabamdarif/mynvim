-- Python Language Configuration
return {
    -- LSP servers to enable
    lsp_servers = { "pyright" },

    -- Formatters by filetype with configuration
    formatters = {
        python = {
            {
                "ruff",
                -- Pass arguments to disable import sorting/organizing
                args = { "format", "--config", "lint.ignore=['F401']", "-" },
            }
        },
    },

    -- Mason packages to install
    mason_packages = {
        "pyright",
        "ruff",
    },

    -- Treesitter parsers
    treesitter = { "python" },
}
