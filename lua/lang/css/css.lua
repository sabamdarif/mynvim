return {
    lsp_servers = { "cssls" },

    lsp_config = {
        -- Don't flag tailwind/postcss directives such as @apply
        cssls = { settings = { css = { lint = { unknownAtRules = "ignore" } } } },
    },

    formatters = { css = { "prettier" }, scss = { "prettier" }, less = { "prettier" } },
    mason_packages = { "css-lsp", "prettier" },
    treesitter = { "css", "scss" },
}
