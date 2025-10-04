-- Load the active colorscheme name
local active_colorscheme = require("colorscheme")

-- Load the colorscheme configuration
local colorscheme_config = require("colorschemes." .. active_colorscheme)

-- Configure for lazy.nvim
colorscheme_config.lazy = false
colorscheme_config.priority = 1000

-- Wrap the original config function
local original_config = colorscheme_config.config
colorscheme_config.config = function()
    if original_config then
        original_config()
    end
    vim.cmd([[colorscheme ]] .. active_colorscheme)
end

return colorscheme_config
