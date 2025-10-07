-- Load the active colorscheme name from settings
local settings = require("settings")
local active_colorscheme = settings.colorscheme

-- Load the colorscheme configuration
local colorscheme_config = require("colorschemes." .. active_colorscheme)

-- Configure for lazy.nvim
colorscheme_config.lazy = false
colorscheme_config.priority = 1000

local original_config = colorscheme_config.config
colorscheme_config.config = function()
    if original_config then
        original_config()
    end
    -- Colorscheme will be applied by init.lua after plugins load
end

return colorscheme_config
