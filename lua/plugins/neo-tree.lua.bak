return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    keys = {
        {
            "<C-n>",
            mode = { "n", "v", "i" },
            function()
                -- Function to check if NeoTree is open in any window
                local function is_neo_tree_open()
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        if vim.bo[buf].filetype == "neo-tree" then
                            return true
                        end
                    end
                    return false
                end

                if is_neo_tree_open() then
                    vim.cmd("Neotree close")
                else
                    vim.cmd("Neotree reveal")
                end
            end,
            desc = "[P]Toggle current file in NeoTree",
        },
    },
    opts = {
        sources = {
            "filesystem",
        },
        retain_hidden_root_indent = true,
        filesystem = {
            filtered_items = {
                visible = true,
                show_hidden_count = true,
                never_show = { ".DS_Store", "thumbs.db", ".git" },
            },
        },
        window = {
            position = "left",
        },
        default_component_configs = {
            indent = {
                with_expanders = true,
                expander_collapsed = "",
                expander_expanded = "",
            },
            icon = {
                folder_closed = "",
                folder_open = "",
                folder_empty = "",
                default = "󰈚",
            },
            git_status = {
                symbols = {
                    added = "✚",
                    modified = "",
                    deleted = "",
                    untracked = "★",
                    ignored = "◌",
                    unstaged = "✗",
                    staged = "✓",
                    conflict = "",
                },
            },
            file_size = {
                enabled = true,
                width = 10,          -- width of the column
                required_width = 35, -- min width of window required to show this column
            },
        },
    },
}
