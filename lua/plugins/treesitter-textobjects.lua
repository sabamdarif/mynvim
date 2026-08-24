return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("nvim-treesitter-textobjects").setup({ select = { lookahead = true } })

        local select = { af = "@function.outer", ["if"] = "@function.inner", ac = "@class.outer", ic = "@class.inner" }
        for lhs, query in pairs(select) do
            vim.keymap.set({ "x", "o" }, lhs, function()
                require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
            end, { desc = "Select " .. query })
        end

        local move = {
            ["]m"] = { "goto_next_start", "@function.outer" },
            ["[m"] = { "goto_previous_start", "@function.outer" },
            ["]]"] = { "goto_next_start", "@class.outer" },
            ["[["] = { "goto_previous_start", "@class.outer" },
        }
        for lhs, spec in pairs(move) do
            local fn, query = spec[1], spec[2]
            vim.keymap.set({ "n", "x", "o" }, lhs, function()
                require("nvim-treesitter-textobjects.move")[fn](query, "textobjects")
            end, { desc = fn .. " " .. query })
        end
    end,
}
