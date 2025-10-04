return {
    "mason-org/mason.nvim",
    build = ":MasonInstallAll",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonInstallAll" },
    config = function()
        require("mason").setup({
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        require("utils.mason-install-all")
    end,
}
