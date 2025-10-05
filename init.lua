-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Set leaders before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load language configurations first
local status_ok, lang_config = pcall(require, "lang")
if not status_ok then
    vim.notify("Failed to load language configs: " .. tostring(lang_config), vim.log.levels.ERROR)
    lang_config = { plugin_specs = {} }
end

-- Setup lazy.nvim with all plugins
local specs = {
    { import = "plugins" },
    require("colorschemes"),
}

-- Add language-specific plugins if any
for _, spec in ipairs(lang_config.plugin_specs or {}) do
    table.insert(specs, spec)
end

-- require("lazy").setup({
--     spec = specs,
-- })
local lazy_config = require("base.lazy_config")
require("lazy").setup(specs, lazy_config)

-- Load core configuration (options, keymaps, autocmds)
require("base")
