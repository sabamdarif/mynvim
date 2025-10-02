return {
    lsp_servers = { "clangd" },
    lsp_config = {
        clangd = {
            filetypes = { "c", "cpp", "objc", "objcpp" },
        },
    },
    formatters = {
        c = { "clang-format" },
        cpp = { "clang-format" },
    },
    mason_packages = {
        "clangd",
        "clang-format",
    },
    treesitter = { "c", "cpp" },
}
