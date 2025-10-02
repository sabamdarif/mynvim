return {
    lsp_servers = { "lua_ls" },

    lsp_config = {
        lua_ls = {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        },
    },

    formatters = {
        lua = { "stylua" },
    },

    mason_packages = {
        "lua-language-server",
    },
    treesitter = { "lua" },
}
