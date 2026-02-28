return {
    lsp_servers = { "pyright", "ruff" },

    lsp_config = {
        ruff = {
            cmd_env = { RUFF_TRACE = "messages" },
            init_options = {
                settings = {
                    logLevel = "error",
                },
            },
        },
    },

    formatters = {
        python = { "ruff_format", "ruff_organize_imports" },
    },

    formatters_config = {
        ruff_format = {
            prepend_args = {},
        },
    },

    mason_packages = {
        "pyright",
        "ruff",
    },

    treesitter = { "python" },
}
