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
    config = function(_, opts)
        require("nvim-tree").setup(opts)

        -- Telescope integration
        local api = require("nvim-tree.api")
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        local view_selection = function(prompt_bufnr)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                local filename = selection.filename
                if filename == nil then
                    filename = selection[1]
                end
                api.tree.find_file(filename, { open = true, focus = true })
                api.node.open.preview()
            end)
            return true
        end

        local function launch_telescope(func_name, opts)
            local telescope_status_ok, _ = pcall(require, "telescope")
            if not telescope_status_ok then
                return
            end
            local node = api.tree.get_node_under_cursor()
            local basedir = node.type == "directory" and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")
            opts = opts or {}
            opts.cwd = basedir
            opts.search_dirs = { basedir }
            opts.attach_mappings = view_selection
            return require("telescope.builtin")[func_name](opts)
        end

        -- keymaps
        vim.keymap.set("n", "<c-f>", function()
            launch_telescope("find_files")
        end, { desc = "Find files from tree node" })

        vim.keymap.set("n", "<c-fg>", function()
            launch_telescope("live_grep")
        end, { desc = "Live grep from tree node" })
    end,
}
