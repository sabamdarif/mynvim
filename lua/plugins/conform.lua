return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "ConformInfo" },
    config = function()
        local lang_config = require("lang")

        local setup_opts = {
            format_on_save = {
                timeout_ms = 3000,
                async = false,
                quiet = false,
                lsp_format = "fallback",
            },
            formatters_by_ft = lang_config.formatters,
        }

        -- Merge custom formatter configurations if they exist
        if lang_config.formatters_config and next(lang_config.formatters_config) then
            setup_opts.formatters = lang_config.formatters_config
        end

        require("conform").setup(setup_opts)
    end,
}
