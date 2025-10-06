return {
    "nvim-tree/nvim-tree.lua",
    priority = 1000,
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = {
        filters = {
            git_ignored = false,
            custom = { "^.git$", ".DS_Store", "thumbs.db", "^.hidden$" },
        },
        live_filter = {
            prefix = "[FILTER]: ",
            always_show_folders = false,
        },
        disable_netrw = true,
        hijack_cursor = true,
        sync_root_with_cwd = true,
        update_focused_file = {
            enable = true,
            update_root = false,
        },
        view = {
            width = 35,
            preserve_window_proportions = true,
        },
        git = {
            enable = true,
            ignore = false,
        },
        renderer = {
            add_trailing = true,
            highlight_git = "all",
            highlight_opened_files = "icon",
            indent_markers = { enable = true },
            icons = {
                glyphs = {
                    default = "󰈚",
                    bookmark = "󰆤",
                    modified = "●",
                    hidden = "󰜌",
                    folder = {
                        default = "",
                        empty = "",
                        empty_open = "",
                        open = "",
                        symlink = "",
                    },
                    git = {
                        unstaged = "✗",
                        staged = "✓",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "★",
                        deleted = "",
                        ignored = "◌",
                    },
                },
            },
        },
    },
    -- config = function(_, opts)
    --     require("nvim-tree").setup(opts)
    --
    --     -- Statusline tweak for tree window
    --     local nt_api = require("nvim-tree.api")
    --     nt_api.events.subscribe(nt_api.events.Event.TreeOpen, function()
    --         local tree_winid = nt_api.tree.winid()
    --         if tree_winid ~= nil then
    --             vim.api.nvim_set_option_value("statusline", "%t", { win = tree_winid })
    --         end
    --     end)
    -- end,
}
