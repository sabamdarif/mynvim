-- Merges every language listed in settings.lua into one table that the plugin
-- specs read from. Add/remove languages in settings.lua, not here.
--
-- A lua/lang/<name>/<name>.lua may return any of:
--   lsp_servers, mason_packages, treesitter   -- lists, deduplicated
--   lsp_config, formatters, formatters_config, luasnip_extends  -- keyed tables
-- A lua/lang/<name>/plugins.lua may return extra lazy.nvim specs.

local M = {
    lsp_servers = {},
    lsp_config = {},
    formatters = {},
    formatters_config = {},
    mason_packages = {},
    treesitter_parsers = {},
    luasnip_extends = {},
    plugin_specs = {},
}

local lists = { lsp_servers = "lsp_servers", mason_packages = "mason_packages", treesitter = "treesitter_parsers" }
local tables = { "lsp_config", "formatters", "formatters_config", "luasnip_extends" }

for _, lang in ipairs(require("settings").languages) do
    local cfg = require("lang." .. lang .. "." .. lang)

    for from, to in pairs(lists) do
        for _, value in ipairs(cfg[from] or {}) do
            if not vim.tbl_contains(M[to], value) then
                table.insert(M[to], value)
            end
        end
    end

    for _, key in ipairs(tables) do
        for name, value in pairs(cfg[key] or {}) do
            M[key][name] = value
        end
    end

    local ok, specs = pcall(require, "lang." .. lang .. ".plugins")
    if ok then
        vim.list_extend(M.plugin_specs, specs)
    end
end

return M
