-- Python Language Configuration
return {
    -- LSP servers to enable
    lsp_servers = { "pyright" },

    -- Formatters by filetype
    formatters = {
        python = { "ruff_format", "ruff_organize_imports" },
    },

    -- Custom formatter configurations (optional)
    formatters_config = {
        ruff_format = {
            -- Ruff format arguments
            prepend_args = {},
        },
        ruff_organize_imports = {
            -- Disable import organizing by making it do nothing
            prepend_args = { "--select", "I001", "--fix" },
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
