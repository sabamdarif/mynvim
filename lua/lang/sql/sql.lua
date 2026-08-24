return {
    lsp_servers = { "sqlls" },
    formatters = { sql = { "sql_formatter" }, mysql = { "sql_formatter" } },
    formatters_config = {
        sql_formatter = { prepend_args = { "-l", "postgresql" } }, -- dialect
    },
    mason_packages = { "sqlls", "sql-formatter" },
    treesitter = { "sql" },
}
