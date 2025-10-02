return {
    {
        "linux-cultist/venv-selector.nvim",
        ft = { "python" },
        keys = {
            { "<leader>ve", "<cmd>VenvSelect<cr>", desc = "Select Python Virtual Environment" },
        },
        opts = {
            name = { "venv", ".venv", "env", ".env" },
        },
    },
}
