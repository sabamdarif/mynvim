-- Python Language Configuration
return {
    -- LSP servers to enable
    lsp_servers = { "pyright" },

    -- Formatters by filetype
    formatters = {
        python = { "ruff" },
    },

    -- Custom formatter configurations (optional)
    formatters_config = {
        ruff = {
            -- Prepend additional arguments to the default ruff command
            prepend_args = { "format", "--config", "lint.ignore=['F401']" },
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
