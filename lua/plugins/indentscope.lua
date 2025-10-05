return {
    {
        "nvim-mini/mini.indentscope",
        version = false,
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            symbol = "▏",
            draw = {
                delay = 700,
                animation = function() return 0 end,
            },
        },
        init = function()
            local excluded_fts = {
                "help", "lazy", "mason", "notify",
                "alpha", "NvimTree", "toggleterm",
            }
            vim.api.nvim_create_autocmd("FileType", {
                pattern = excluded_fts,
                callback = function()
                    vim.b.miniindentscope_disable = true
                    vim.opt_local.list = false
                end,
            })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "*",
                callback = function()
                    -- Exclude nofile buffers (popups, notifications, etc.)
                    if not vim.tbl_contains(excluded_fts, vim.bo.filetype) and vim.bo.buftype ~= "nofile" then
                        vim.opt_local.listchars:append({ leadmultispace = "▏   " })
                        vim.opt_local.list = true
                    end
                end,
            })
        end,
    },
}
