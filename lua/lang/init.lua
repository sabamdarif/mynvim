-- ╔══════════════════════════════════════════════════════════════════════════════╗
-- ║                         LANGUAGE CONFIGURATION                               ║
-- ║                                                                              ║
-- ║  Add or remove language modules here to customize your development setup.    ║
-- ║  Each language file in lua/lang/ defines LSP servers, formatters, etc.       ║
-- ╚══════════════════════════════════════════════════════════════════════════════╝

local languages = {
    "lang.bash",
    "lang.python",
    "lang.javascript",
    "lang.html",
    "lang.css",
    "lang.markdown",
    "lang.lua",
}

-- ════════════════════════════════════════════════════════════════════════════════
--                     Internal Configuration (Don't modify)
-- ════════════════════════════════════════════════════════════════════════════════

-- Central language configuration loader
local M = {
    lsp_servers = {},
    lsp_config = {},
    formatters = {},
    mason_packages = {},
    plugins = {},
    treesitter_parsers = {},
}

-- Load and merge all language configurations
for _, lang_module in ipairs(languages) do
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

        -- Merge plugins
        if lang_config.plugins then
            for _, plugin in ipairs(lang_config.plugins) do
                table.insert(M.plugins, plugin)
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
end

-- Remove duplicates
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

M.lsp_servers = deduplicate(M.lsp_servers)
M.mason_packages = deduplicate(M.mason_packages)
M.treesitter_parsers = deduplicate(M.treesitter_parsers)

return M
