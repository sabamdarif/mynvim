-- Bash Language Configuration
return {
    -- LSP servers to enable
    lsp_servers = { "bashls" },

    -- LSP server-specific configurations
    lsp_config = {
        bashls = {
            filetypes = { "sh", "bash", "zsh" },
            settings = {
                bashIde = {
                    globPattern = "**/*@(.sh|.inc|.bash|.command|.zsh|.zshrc)",
                },
            },
        },
    },

    -- Formatters by filetype
    formatters = {
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
    },

    -- Mason packages to install
    mason_packages = {
        "bash-language-server",
        "shfmt",
        "shellcheck",
    },

    -- Treesitter parsers
    treesitter = { "bash" },
}
