-- vim.api.nvim_set_hl(0, "TreesitterContext", { link = "Normal" })
vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { link = "LineNr" })
vim.api.nvim_set_hl(0, "TreesitterContextBottom", {})

return {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" }, -- Changed from "LazyFile"
    opts = {
        enable = true,                    -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 5,                    -- How many lines the window should span. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 5,          -- Maximum number of lines to show for a single context
        zindex = 10,                      -- The Z-index of the context window
    },
    keys = {
        {
            "<leader>ut",
            function()
                local tsc = require("treesitter-context")
                tsc.toggle()
                -- Simplified toggle feedback without LazyVim dependencies
                vim.notify("Toggled Treesitter Context")
            end,
            desc = "Toggle Treesitter Context",
        },
    },
}
