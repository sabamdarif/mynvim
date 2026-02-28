-- add custom bash filetypes
vim.filetype.add({
    filename = {
        [".bashrc"] = "bash",
        [".bash_profile"] = "bash",
        [".shell_aliases"] = "bash",
        [".shell_functions"] = "bash",
        [".zshrc"] = "zsh",
    },
    pattern = {
        [".*%.bash"] = "bash",
        [".*%.zsh"] = "zsh",
    },
})

-- Bash Language Configuration
return {
    -- LSP servers to enable
    lsp_servers = { "bashls" },

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
