-- Dotfiles nvim doesn't recognise on its own
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

return {
    lsp_servers = { "bashls" },
    formatters = { sh = { "shfmt" }, bash = { "shfmt" }, zsh = { "shfmt" } },
    mason_packages = { "bash-language-server", "shfmt", "shellcheck" },
    treesitter = { "bash" },
}
