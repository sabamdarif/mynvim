return {
    lsp_servers = { "clangd" },
    formatters = { c = { "clang-format" }, cpp = { "clang-format" } },
    mason_packages = { "clangd", "clang-format" },
    treesitter = { "c", "cpp" },
}
