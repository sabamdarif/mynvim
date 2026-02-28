return {
    -- LSP servers to enable (if you want to use a specific django lsp, though pyright usually handles it)
    -- You might want to add "emmet_ls" here if you want emmet support in django templates
    lsp_servers = {},

    -- Formatters by filetype
    formatters = {
        htmldjango = { "djlint" },
        django = { "djlint" },
    },

    -- Custom formatter configurations
    formatters_config = {},

    -- Mason packages to install
    mason_packages = {
        "djlint",
    },

    -- Treesitter parsers
    treesitter = { "htmldjango" },

    -- LuaSnip filetype extensions
    luasnip_extends = {
        htmldjango = { "html" },
    },
}
