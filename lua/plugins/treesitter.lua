return {
    "nvim-treesitter/nvim-treesitter",
    -- branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
        local lang_config = require("lang")
        return {
            -- Automatically install missing parsers when entering buffer
            auto_install = true,
            -- Install parsers from language configs
            ensure_installed = lang_config.treesitter_parsers or {},
            -- List of parsers to ignore installing
            ignore_install = { "awk" },
            highlight = { enable = true },
            indent = { enable = true },
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
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
