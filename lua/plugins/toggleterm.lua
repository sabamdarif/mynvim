return {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    opts = {
        size = 10,
        open_mapping = [[<C-\>]],
        shading_factor = 2,       -- the percentage by which to lighten dark terminal background, default: -30
        direction = "horizontal", -- 'vertical' | 'horizontal' | 'tab' | 'float',
        float_opts = {
            border = "curved",
        },
    },
}
