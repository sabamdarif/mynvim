return {
    {
        "linux-cultist/venv-selector.nvim",
        ft = { "python" },
        keys = {
            { "<leader>vs", "<cmd>VenvSelect<cr>",       desc = "Select Python Virtual Environment" },
            { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Select Cached Venv" },
        },
        opts = {
            name = { "venv", ".venv", "env", ".env" },
        },
    },
}
