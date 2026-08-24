return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        keys = {
            { "<leader>mp", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle markdown render" },
            { "<leader>me", "<cmd>RenderMarkdown expand<cr>", desc = "Expand markdown render" },
            { "<leader>mc", "<cmd>RenderMarkdown contract<cr>", desc = "Contract markdown render" },
        },
        -- Everything here differs from the plugin defaults.
        opts = {
            completions = { blink = { enabled = true }, lsp = { enabled = true } },
            checkbox = {
                unchecked = { icon = "   󰄱 " },
                checked = { icon = "   󰱒 " },
            },
            html = { comment = { conceal = false } },
            heading = {
                sign = false,
                width = "block",
                icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
            },
            pipe_table = { preset = "heavy", padding = 2, min_width = 5 },
            link = {
                custom = {
                    discord = { pattern = "discord%.com", icon = "󰙯 " },
                    github = { pattern = "github%.com", icon = "󰊤 " },
                    gitlab = { pattern = "gitlab%.com", icon = "󰮠 " },
                    google = { pattern = "google%.com", icon = "󰊭 " },
                    reddit = { pattern = "reddit%.com", icon = "󰑍 " },
                    stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌 " },
                    wikipedia = { pattern = "wikipedia%.org", icon = "󰖬 " },
                    youtu = { pattern = "youtu%.be", icon = "󰗃 " },
                },
            },
        },
    },
    {
        -- Browser preview for markdown/HTML, toggled with <leader>lp
        "brianhuster/live-preview.nvim",
        cmd = "LivePreview",
        dependencies = { "nvim-telescope/telescope.nvim" },
    },
}
