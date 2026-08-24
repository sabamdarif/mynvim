return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = "ConformInfo",
    config = function()
        local lang = require("lang")
        require("conform").setup({
            format_on_save = { timeout_ms = 3000, lsp_format = "fallback" },
            formatters_by_ft = lang.formatters,
            formatters = lang.formatters_config,
        })
    end,
}
