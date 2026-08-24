return {
    "akinsho/bufferline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            max_name_length = 30,
            max_prefix_length = 30,
            separator_style = "thin",
            indicator = { style = "underline" },
            offsets = { { filetype = "NvimTree", text = " " } },
        },
    },
}
