return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            --            
            section_separators = { left = "", right = "" },
            component_separators = { left = "", right = "" },
            globalstatus = true,
        },
        sections = {
            lualine_a = { { "mode", icon = "" } },
            lualine_b = {
                { "filetype", icon_only = true, separator = "", icon = { align = "right" }, padding = { left = 1, right = 0 } },
                { "filename", path = 0, padding = { left = 0, right = 0 } },
                { "filesize" },
            },
            lualine_c = {},
            lualine_x = { { "diagnostics" } },
            lualine_y = { { "branch" }, { "diff" }, { "encoding" } },
            lualine_z = { { "lsp_status", icon = "" } },
        },
        extensions = { "quickfix", "nvim-tree", "lazy", "mason", "toggleterm" },
    },
}
