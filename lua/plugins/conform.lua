return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    config = function()
        local lang_config = require("lang")

        require("conform").setup({
            format_on_save = {
                timeout_ms = 3000,
                async = false,
                quiet = false,
                lsp_format = "fallback",
            },
            formatters_by_ft = lang_config.formatters,
        })
    end,
}
