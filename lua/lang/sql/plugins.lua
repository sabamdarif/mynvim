return {
    {
        "sabamdarif/sqlua.nvim",
        lazy = true,
        branch = "master",
        cmd = { "SQLua", "SQLuaOpen" },
        -- Load the plugin when opening database files
        event = { "BufEnter *.db", "BufEnter *.sqlite", "BufEnter *.sqlite3", "BufEnter *.s3db" },
        config = function()
            require("sqlua").setup()
        end,
    },
}
