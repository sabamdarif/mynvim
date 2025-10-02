return {
    "dstein64/nvim-scrollview",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("scrollview").setup({
            excluded_filetypes = { "nerdtree", "NvimTree" },
            current_only = true,
            base = "right",
            column = 1,
            signs_on_startup = { "diagnostics", "search", "gitsigns" },
            diagnostics_severities = { vim.diagnostic.severity.ERROR },
        })
        require("scrollview.contrib.gitsigns").setup({
            show_in_folds = true,
            current_only = true,
            priority = 10,
        })
    end,
}
