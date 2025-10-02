return {
    "akinsho/bufferline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
        options = {
            themable = true,
            max_name_length = 30,
            max_prefix_length = 30,
            tab_size = 20,
            separator_style = "thin",
            enforce_regular_tabs = true,
            show_tab_indicators = false,
            indicator = {
                style = "underline", -- "icon", "underline", "none"
            },
            offsets = {
                {
                    filetype = "NvimTree", -- neo-tree or NvimTree
                    text = " ",
                    separator = "┃",
                },
            },
        },
    },
}
