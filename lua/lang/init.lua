-- ════════════════════════════════════════════════════════════════════════════════
--                     Language Configuration Loader
-- ════════════════════════════════════════════════════════════════════════════════
-- This file automatically loads all language configurations defined in settings.lua
-- Do not modify this file unless you know what you're doing.
-- To add/remove languages, edit lua/settings.lua instead.
-- ════════════════════════════════════════════════════════════════════════════════

-- Load the list of enabled languages from settings.lua
local settings = require("settings")
local languages = settings.languages

-- Central language configuration aggregator
local M = {
    lsp_servers = {},
    lsp_config = {},
    formatters = {},
    mason_packages = {},
    treesitter_parsers = {},
    plugin_specs = {}, -- Collect all plugin specs
}

-- Helper function to remove duplicates from array
local function deduplicate(tbl)
    local seen = {}
    local result = {}
    for _, value in ipairs(tbl) do
        if not seen[value] then
            seen[value] = true
            table.insert(result, value)
        end
    end
    return result
end

-- Load and merge all language configurations
for _, lang in ipairs(languages) do
    -- Load main language config (LSP, formatters, etc.)
    local lang_module = "lang." .. lang .. "." .. lang
    local status_ok, lang_config = pcall(require, lang_module)

    if status_ok then
        -- Merge LSP servers
        if lang_config.lsp_servers then
            for _, server in ipairs(lang_config.lsp_servers) do
                table.insert(M.lsp_servers, server)
            end
        end

        -- Merge LSP configurations
        if lang_config.lsp_config then
            for server, config in pairs(lang_config.lsp_config) do
                M.lsp_config[server] = config
            end
        end

        -- Merge formatters
        if lang_config.formatters then
            for ft, formatters in pairs(lang_config.formatters) do
                M.formatters[ft] = formatters
            end
        end

        -- Merge Mason packages
        if lang_config.mason_packages then
            for _, package in ipairs(lang_config.mason_packages) do
                table.insert(M.mason_packages, package)
            end
        end

        -- Merge treesitter parsers
        if lang_config.treesitter then
            for _, parser in ipairs(lang_config.treesitter) do
                table.insert(M.treesitter_parsers, parser)
            end
        end
    else
        vim.notify(
            "Failed to load: " .. lang_module .. "\nError: " .. tostring(lang_config),
            vim.log.levels.WARN
        )
    end

    -- Load language-specific plugins
    local plugin_module = "lang." .. lang .. ".plugins"
    local plugin_ok, plugin_specs = pcall(require, plugin_module)

    if plugin_ok then
        -- Plugin module should return an array of plugin specs
        if type(plugin_specs) == "table" then
            for _, spec in ipairs(plugin_specs) do
                table.insert(M.plugin_specs, spec)
            end
        end
    end
    -- Silently ignore if plugins.lua doesn't exist for this language
end

-- Deduplicate arrays
M.lsp_servers = deduplicate(M.lsp_servers)
M.mason_packages = deduplicate(M.mason_packages)
M.treesitter_parsers = deduplicate(M.treesitter_parsers)

return M
