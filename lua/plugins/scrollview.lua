return {
    "dstein64/nvim-scrollview",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("scrollview").setup({
            excluded_filetypes = { "NvimTree" },
            current_only = true,
            signs_on_startup = { "diagnostics", "search", "gitsigns" },
            diagnostics_severities = { vim.diagnostic.severity.ERROR },
        })
        require("scrollview.contrib.gitsigns").setup({ show_in_folds = true, current_only = true })
    end,
}
