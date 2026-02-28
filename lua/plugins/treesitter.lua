return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate | TSInstallAll",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
        local lang_config = require("lang")
        local base_parsers = {
            "diff",
            "printf",
            "query",
            "regex",
            "vim",
            "vimdoc",
            "xml",
            "luadoc",
            "luap",
        }
        local parsers = vim.list_extend(base_parsers, lang_config.treesitter_parsers or {})
        return {
            auto_install = true,
            ensure_installed = parsers,
            ignore_install = { "awk" },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        }
    end,
}
