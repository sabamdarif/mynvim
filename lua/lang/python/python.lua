return {
    lsp_servers = { "pyright", "ruff" },

    lsp_config = {
        -- ruff is noisy on stderr at the default log level
        ruff = {
            cmd_env = { RUFF_TRACE = "messages" },
            init_options = { settings = { logLevel = "error" } },
        },
    },

    formatters = { python = { "ruff_format", "ruff_organize_imports" } },
    mason_packages = { "pyright", "ruff" },
    treesitter = { "python" },
}
