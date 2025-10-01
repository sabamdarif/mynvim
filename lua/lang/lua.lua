return {
    lsp_servers = { "lua_ls" },

    formatters = {
        lua = { "stylua" },
    },

    mason_packages = {
        "lua-language-server",
    },
    treesitter = { "lua" },
}
