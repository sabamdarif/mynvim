return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        -- Setup textobjects configuration
        require("nvim-treesitter-textobjects").setup({
            select = {
                enable = true,
                lookahead = true,
            },
            move = {
                enable = true,
                set_jumps = true,
            },
        })

        local keymap = vim.keymap.set

        keymap({ "x", "o" }, "af", function()
            require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
        end, { desc = "Select outer function" })

        keymap({ "x", "o" }, "if", function()
            require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
        end, { desc = "Select inner function" })

        keymap({ "x", "o" }, "ac", function()
            require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
        end, { desc = "Select outer class" })

        keymap({ "x", "o" }, "ic", function()
            require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
        end, { desc = "Select inner class" })

        -- Movement keymaps
        keymap({ "n", "x", "o" }, "]m", function()
            require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
        end, { desc = "Next function start" })

        keymap({ "n", "x", "o" }, "[m", function()
            require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
        end, { desc = "Previous function start" })

        keymap({ "n", "x", "o" }, "]]", function()
            require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
        end, { desc = "Next class start" })

        keymap({ "n", "x", "o" }, "[[", function()
            require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
        end, { desc = "Previous class start" })
    end,
}
