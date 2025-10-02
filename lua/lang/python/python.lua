-- Python Language Configuration
return {
    -- LSP servers to enable
    lsp_servers = { "ruff" },

    -- Formatters by filetype
    formatters = {
        python = { "ruff" },
    },

    -- Mason packages to install
    mason_packages = {
        "ruff", -- Optional: fast Python linter
    },

    -- Treesitter parsers
    treesitter = { "python" },
}
