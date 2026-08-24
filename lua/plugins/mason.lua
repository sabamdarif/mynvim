return {
    "mason-org/mason.nvim",
    build = ":MasonInstallAll",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonInstallAll" },
    opts = {
        ui = {
            border = "rounded",
            icons = {
                package_pending = " ",
                package_installed = " ",
                package_uninstalled = " ",
            },
        },
    },
    config = function(_, opts)
        require("mason").setup(opts)

        -- Install every tool the languages in settings.lua ask for.
        vim.api.nvim_create_user_command("MasonInstallAll", function()
            local registry = require("mason-registry")
            registry.refresh(function()
                local missing = {}
                for _, name in ipairs(require("lang").mason_packages) do
                    if not registry.has_package(name) then
                        vim.notify("Mason has no package named " .. name, vim.log.levels.WARN)
                    elseif not registry.get_package(name):is_installed() then
                        table.insert(missing, name)
                    end
                end

                if #missing == 0 then
                    vim.notify("Mason: everything is already installed")
                else
                    vim.notify("Mason: installing " .. table.concat(missing, ", "))
                    vim.cmd("MasonInstall " .. table.concat(missing, " "))
                end
            end)
        end, { desc = "Install Mason packages for the enabled languages" })
    end,
}
