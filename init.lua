vim.g.mapleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- load all plugins
local specs = {
    { import = "plugins" },
    require("colorschemes"),
}

-- Load language configurations first
local status_ok, lang_config = pcall(require, "lang")
if not status_ok then
    vim.notify("Failed to load language configs: " .. tostring(lang_config), vim.log.levels.ERROR)
    lang_config = { plugin_specs = {} }
end

-- Add language-specific plugins if any
for _, spec in ipairs(lang_config.plugin_specs or {}) do
    table.insert(specs, spec)
end

-- Lazy.nvim options
local opts = {
    defaults = { lazy = true },
    ui = {
        icons = {
            ft = "",
            lazy = "󰂠 ",
            loaded = "",
            not_loaded = "",
        },
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "2html_plugin",
                "tohtml",
                "getscript",
                "getscriptPlugin",
                "gzip",
                "logipat",
                "netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                "matchit",
                "tar",
                "tarPlugin",
                "rrhelper",
                "spellfile_plugin",
                "vimball",
                "vimballPlugin",
                "zip",
                "zipPlugin",
                "tutor",
                "rplugin",
                "syntax",
                "synmenu",
                "optwin",
                "compiler",
                "bugreport",
                "ftplugin",
            },
        },
    },
}

require("lazy").setup(specs, opts)

require("base")

-- CRITICAL: Apply colorscheme AFTER all plugins load
vim.schedule(function()
    local settings = require("settings")
    vim.cmd.colorscheme(settings.colorscheme)
end)
