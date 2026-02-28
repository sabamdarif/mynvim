-- SQL Language Configuration
return {
    -- LSP servers to enable
    lsp_servers = { "sqlls" },

    -- Formatters by filetype
    formatters = {
        sql = { "sql_formatter" },
        mysql = { "sql_formatter" },
    },

    -- Custom formatter configurations (optional)
    formatters_config = {
        sql_formatter = {
            -- sql-formatter arguments
            prepend_args = { "-l", "postgresql" }, -- Default to postgresql dialect, user can change
        },
    },

    -- Mason packages to install
    mason_packages = {
        "sqlls",
        "sql-formatter",
    },

    -- Treesitter parsers
    treesitter = { "sql" },
}
