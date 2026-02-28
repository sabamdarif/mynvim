return {
    lsp_servers = { "yamlls" },

    lsp_config = {
        yamlls = {
            capabilities = {
                textDocument = {
                    foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true,
                    },
                },
            },
            before_init = function(_, new_config)
                new_config.settings.yaml.schemas = vim.tbl_deep_extend("force", new_config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
            end,
            settings = {
                redhat = { telemetry = { enabled = false } },
                yaml = {
                    keyOrdering = false,
                    format = { enable = true },
                    validate = true,
                    schemaStore = {
                        enable = false,
                        url = "",
                    },
                },
            },
        },
    },

    formatters = {
        yaml = { "prettier" },
    },

    mason_packages = {
        "yaml-language-server",
        "prettier",
    },

    treesitter = { "yaml" },
}
