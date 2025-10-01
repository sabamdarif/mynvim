return {
    lsp_servers = { "pyright" },

    lsp_config = {
        pyright = {
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "basic",
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                    },
                },
            },
        },
    },

    formatters = {
        python = { "black", "isort" },
    },

    mason_packages = {
        "pyright",
        "black",
        "isort",
    },

    treesitter = { "python" },
}
