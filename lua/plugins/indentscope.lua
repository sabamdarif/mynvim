return {
    {
        "nvim-mini/mini.indentscope",
        version = false,
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            symbol = "▏",
            draw = {
                delay = 700,
                animation = function() return 0 end, -- Disable animation for instant scope display (return 0 means no animation)
            },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help", "lazy", "mason", "notify",
                    "alpha", "NvimTree", "toggleterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true -- Disable mini.indentscope highlighting for this buffer
                end,
            })
            -- Enable showing all indent lines
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    vim.opt_local.listchars:append({ leadmultispace = "▏   " })
                    vim.opt_local.list = true -- Also disable listchars (indent lines) for this buffer
                end,
            })
        end,
    },
}
