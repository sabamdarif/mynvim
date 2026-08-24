return {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = { max_lines = 5, multiline_threshold = 5, zindex = 10 },
    keys = {
        {
            "<leader>tc",
            function()
                local tsc = require("treesitter-context")
                tsc.toggle()
                vim.notify("Treesitter context " .. (tsc.enabled() and "enabled" or "disabled"))
            end,
            desc = "Toggle treesitter context",
        },
    },
}
