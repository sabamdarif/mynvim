return {
    {
        "sabamdarif/sqlua.nvim",
        branch = "master",
        cmd = { "SQLua", "SQLuaOpen" },
        event = { "BufEnter *.db", "BufEnter *.sqlite", "BufEnter *.sqlite3", "BufEnter *.s3db" },
        opts = {},
    },
}
