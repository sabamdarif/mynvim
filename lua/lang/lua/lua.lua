return {
    lsp_servers = { "lua_ls" },

    lsp_config = {
        lua_ls = {
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                    workspace = { checkThirdParty = false },
                    completion = { callSnippet = "Replace" },
                    doc = { privateName = { "^_" } },
                    hint = {
                        enable = true,
                        paramType = true,
                        setType = false,
                        paramName = "Disable",
                        semicolon = "Disable",
                        arrayIndex = "Disable",
                    },
                },
            },
        },
    },

    formatters = { lua = { "stylua" } },
    mason_packages = { "lua-language-server", "stylua" },
    treesitter = { "lua" },
}
