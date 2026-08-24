return {
    lsp_servers = { "jsonls" },

    lsp_config = {
        jsonls = {
            -- Feed the server SchemaStore's catalogue (see plugins.lua)
            before_init = function(_, config)
                config.settings.json.schemas = vim.list_extend(
                    config.settings.json.schemas or {},
                    require("schemastore").json.schemas()
                )
            end,
            settings = { json = {} },
        },
    },

    formatters = { json = { "prettier" }, jsonc = { "prettier" } },
    mason_packages = { "json-lsp", "prettier" },
    treesitter = { "json", "jsonc", "json5" },
}
