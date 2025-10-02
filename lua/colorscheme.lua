local active_colorscheme = "tokyodark"
-- local active_colorscheme = "catppuccin"
-- local active_colorscheme = "nightfox"
-- local active_colorscheme = "gruvbox"

local colorscheme_config = require("colorschemes." .. active_colorscheme)

colorscheme_config.lazy = false
colorscheme_config.priority = 1000

local original_config = colorscheme_config.config
colorscheme_config.config = function()
    if original_config then
        original_config()
    end
    vim.cmd([[colorscheme ]] .. active_colorscheme)
end

return colorscheme_config
