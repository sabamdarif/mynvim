return {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        keywords = {
            WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX", "#WARNING" } },
            PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "OPTI", "#OPTIM", "#OPTI" } },
            NOTE = { icon = " ", color = "hint", alt = { "INFO", "#NOTE", "#INFO" } },
        },
    },
}
