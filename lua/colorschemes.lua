-- Only the colorscheme named in settings.lua gets installed.
local specs = {
    tokyodark = { "tiagovla/tokyodark.nvim", name = "tokyodark" },
    nightfox = { "EdenEast/nightfox.nvim" },
    gruvbox = { "ellisonleao/gruvbox.nvim" },
    catppuccin = {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            custom_highlights = function(colors)
                return {
                    BufferLineBufferSelected = { fg = "#32D1FD" },
                    Comment = { fg = colors.flamingo },
                    CursorLine = { bg = "#3f404f" },
                    DiffChange = { bg = "#a6e3a1", fg = "black" },
                    DiffDelete = { bg = "#f38ba8", fg = "black" },
                    Visual = { bg = "#7ec9d8", fg = "white" },
                }
            end,
        },
    },
}

local name = require("settings").colorscheme
local spec = assert(specs[name], "unknown colorscheme in settings.lua: " .. name)
spec.lazy = false
spec.priority = 1000
return spec
