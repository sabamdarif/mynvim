return {
    lsp_servers = { "yamlls" },

    lsp_config = {
        yamlls = {
            -- yamlls only folds when the client asks for line-based folding
            capabilities = {
                textDocument = {
                    foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
                },
            },
            -- Use the SchemaStore plugin's catalogue instead of the server's own
            before_init = function(_, config)
                config.settings.yaml.schemas =
                    vim.tbl_deep_extend("force", config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
            end,
            settings = {
                redhat = { telemetry = { enabled = false } },
                yaml = {
                    keyOrdering = false,
                    format = { enable = true },
                    schemaStore = { enable = false, url = "" },
                },
            },
        },
    },

    formatters = { yaml = { "prettier" } },
    mason_packages = { "yaml-language-server", "prettier" },
    treesitter = { "yaml" },
}
