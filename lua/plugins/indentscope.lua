return {
    "nvim-mini/mini.indentscope",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        symbol = "▏",
        draw = {
            delay = 700,
            animation = function()
                return 0
            end,
        },
    },
    init = function()
        -- 'list'/'leadmultispace' draws the static guides (set in base/options.lua);
        -- turn both it and the animated scope off for UI and scratch buffers.
        local excluded = { "help", "lazy", "mason", "notify", "NvimTree", "toggleterm" }
        vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
            callback = function()
                local off = vim.tbl_contains(excluded, vim.bo.filetype) or vim.bo.buftype ~= ""
                vim.b.miniindentscope_disable = off
                vim.opt_local.list = not off
            end,
        })
    end,
}
