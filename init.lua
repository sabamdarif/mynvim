vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local specs = {
    { import = "plugins" },
    require("colorschemes"),
}
vim.list_extend(specs, require("lang").plugin_specs)

require("lazy").setup(specs, {
    defaults = { lazy = true },
    ui = { icons = { ft = " ", lazy = "󰂠 ", loaded = " ", not_loaded = " " } },
    performance = {
        rtp = {
            disabled_plugins = { "gzip", "matchit", "netrwPlugin", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
        },
    },
})

require("base")

-- Must run after plugins load, otherwise the scheme isn't on the rtp yet.
vim.schedule(function()
    vim.cmd.colorscheme(require("settings").colorscheme)
end)
