return {
    "goolord/alpha-nvim",
    lazy = false,
    priority = 1000,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = function()
        local dashboard = require("alpha.themes.dashboard")

        local logo = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
    ]]

        vim.api.nvim_create_user_command("ColorschemeWithPreview", function()
            require("telescope.builtin").colorscheme({ enable_preview = true })
        end, {})

        dashboard.section.header.val = vim.split(logo, "\n")

        dashboard.section.buttons.val = {
            dashboard.button("ff", "  Find file", "<cmd>Telescope find_files<cr>"),
            dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<cr>"),
            dashboard.button("n", "  New file", "<cmd> ene <BAR> startinsert <cr>"),
            dashboard.button("th", "󱥚  Themes", "<cmd>ColorschemeWithPreview<cr>"),
            dashboard.button("l", "󰒲  Lazy", "<cmd> Lazy <cr>"),
            dashboard.button("k", "  List Keymaps", "<cmd>Telescope keymaps<cr>"),
            dashboard.button("q", "  Quit", "<cmd> qa <cr>"),
        }

        for _, btn in ipairs(dashboard.section.buttons.val) do
            btn.opts.hl = "AlphaButtons"
            btn.opts.hl_shortcut = "AlphaShortcut"
        end

        dashboard.section.header.opts.hl = "AlphaHeader"
        dashboard.section.buttons.opts.hl = "AlphaButtons"
        dashboard.section.footer.opts.hl = "AlphaFooter"
        dashboard.opts.layout[1].val = 8

        -- Handle Lazy + Alpha integration
        if vim.o.filetype == "lazy" then
            vim.cmd.close()
            vim.api.nvim_create_autocmd("User", {
                once = true,
                pattern = "AlphaReady",
                callback = function()
                    require("lazy").show()
                end,
            })
        end

        -- Footer: show startup stats after LazyVim loads
        vim.api.nvim_create_autocmd("User", {
            once = true,
            pattern = "LazyVimStarted",
            callback = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                dashboard.section.footer.val = "  Neovim loaded "
                    .. stats.loaded
                    .. "/"
                    .. stats.count
                    .. " plugins in "
                    .. ms
                    .. "ms"
                pcall(vim.cmd.AlphaRedraw)
            end,
        })

        return dashboard.opts
    end,
}
