-- A custom sorter bypasses nvim-tree's own folders_first handling, so the
-- directory check has to live in the comparator itself.
local function is_dir(node)
    if node.type == "directory" then
        return true
    end
    if node.type == "link" and node.link_to then
        local stat = vim.uv.fs_stat(node.link_to)
        return stat ~= nil and stat.type == "directory"
    end
    return false
end

-- Natural sort: compare embedded numbers numerically, so files order as
-- "1 foo, 3 foo, 20 foo" instead of "1 foo, 20 foo, 3 foo".
local function natural_cmp(left, right)
    local left_dir, right_dir = is_dir(left), is_dir(right)
    if left_dir ~= right_dir then
        return left_dir
    end

    left, right = left.name:lower(), right.name:lower()
    if left == right then
        return false
    end

    for i = 1, math.max(#left, #right) do
        local l, r = left:sub(i), right:sub(i)
        local l_number, r_number = tonumber(l:match("^%d+")), tonumber(r:match("^%d+"))

        if l_number and r_number then
            if l_number ~= r_number then
                return l_number < r_number
            end
        elseif l:sub(1, 1) ~= r:sub(1, 1) then
            return l < r
        end
    end
end

-- Search from the node under the cursor, and jump the tree to whatever is picked.
local function launch_telescope(builtin)
    local api = require("nvim-tree.api")
    local actions = require("telescope.actions")
    local node = api.tree.get_node_under_cursor()
    local basedir = node.type == "directory" and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")

    require("telescope.builtin")[builtin]({
        cwd = basedir,
        search_dirs = { basedir },
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = require("telescope.actions.state").get_selected_entry()
                api.tree.find_file(selection.filename or selection[1], { open = true, focus = true })
                api.node.open.preview()
            end)
            return true
        end,
    })
end

return {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
        sort = {
            sorter = function(nodes)
                table.sort(nodes, natural_cmp)
            end,
        },
        filters = {
            git_ignored = false,
            custom = { "^.git$", ".DS_Store", "thumbs.db", "^.hidden$" },
        },
        hijack_cursor = true,
        sync_root_with_cwd = true,
        update_focused_file = { enable = true },
        renderer = {
            add_trailing = true,
            highlight_git = "all",
            highlight_opened_files = "icon",
            indent_markers = { enable = true },
        },
        on_attach = function(bufnr)
            require("nvim-tree.api").config.mappings.default_on_attach(bufnr)
            vim.keymap.set("n", "<C-f>", function()
                launch_telescope("find_files")
            end, { buffer = bufnr, desc = "nvim-tree: find files under node" })
            vim.keymap.set("n", "<C-g>", function()
                launch_telescope("live_grep")
            end, { buffer = bufnr, desc = "nvim-tree: live grep under node" })
        end,
    },
}
