return {
    lsp_servers = { "bashls" },

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

    formatters = {
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
    },

    mason_packages = {
        "bash-language-server",
        "shfmt",
    },

    treesitter = { "bash" },
}
