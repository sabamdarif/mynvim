-- Markdown-specific plugins
return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        keys = {
            {
                "<leader>mp",
                "<cmd>RenderMarkdown toggle<cr>",
                desc = "Toggle Markdown Preview",
            },
            {
                "<leader>me",
                "<cmd>RenderMarkdown expand<cr>",
                desc = "Expand Markdown",
            },
            {
                "<leader>mc",
                "<cmd>RenderMarkdown contract<cr>",
                desc = "Contract Markdown",
            },
        },
        opts = {
            completions = {
                blink = { enabled = true },
                coq = { enabled = false },
                lsp = { enabled = true },
            },
            bullet = {
                enabled = true,
            },
            checkbox = {
                enabled = true,
                unchecked = {
                    icon = "   󰄱 ",
                    highlight = "RenderMarkdownUnchecked",
                    scope_highlight = nil,
                },
                checked = {
                    icon = "   󰱒 ",
                    highlight = "RenderMarkdownChecked",
                    scope_highlight = nil,
                },
            },
            html = {
                enabled = true,
                comment = {
                    conceal = false,
                },
            },
            link = {
                image = "󰥶 ",
                email = "󰀓 ",
                hyperlink = "󰌹 ",
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
            heading = {
                sign = false,
                width = "block",
                icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
                backgrounds = {
                    "RenderMarkdownH1Bg",
                    "RenderMarkdownH2Bg",
                    "RenderMarkdownH3Bg",
                    "RenderMarkdownH4Bg",
                    "RenderMarkdownH5Bg",
                    "RenderMarkdownH6Bg",
                },
                foregrounds = {
                    "RenderMarkdownH1",
                    "RenderMarkdownH2",
                    "RenderMarkdownH3",
                    "RenderMarkdownH4",
                    "RenderMarkdownH5",
                    "RenderMarkdownH6",
                },
            },
            pipe_table = {
                enabled = true,
                render_modes = false,
                preset = "heavy",
                style = "full",
                cell = "padded",
                padding = 2,
                min_width = 5,
                border = {
                    '┌', '┬', '┐',
                    '├', '┼', '┤',
                    '└', '┴', '┘',
                    '│', '─',
                },
                border_virtual = false,
                alignment_indicator = "━",
                head = "RenderMarkdownTableHead",
                row = "RenderMarkdownTableRow",
                filler = "RenderMarkdownTableFill",
            },
        },
    },
    {
        "brianhuster/live-preview.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
    },
}
