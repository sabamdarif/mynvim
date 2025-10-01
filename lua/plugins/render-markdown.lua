return {
    "MeanderingProgrammer/render-markdown.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        -- get help from:- https://github.com/linkarzu/dotfiles-latest/blob/main/neovim/neobean/lua/plugins/render-markdown.lua
        completions = {
            -- Settings for blink.cmp completions source
            blink = { enabled = true },
            -- Settings for coq_nvim completions source
            coq = { enabled = false },
            -- Settings for in-process language server completions
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
            -- Inlined with 'image' elements.
            image = "󰥶 ",
            -- Inlined with 'email_autolink' elements.
            email = "󰀓 ",
            -- Fallback icon for 'inline_link' and 'uri_autolink' elements.
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
            -- Width of the heading background.
            -- | block | width of the heading text |
            -- | full  | full width of the window  |
            -- Can also be a list of the above values evaluated by `clamp(value, context.level)`.
            width = "block", -- This ensures only the heading text gets colored, not the full line
            icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
            backgrounds = {
                "RenderMarkdownH1Bg",
                "RenderMarkdownH2Bg",
                "RenderMarkdownH3Bg",
                "RenderMarkdownH4Bg",
                "RenderMarkdownH5Bg",
                "RenderMarkdownH6Bg",
            },
            -- Highlight for the heading and sign icons.
            -- Output is evaluated using the same logic as 'backgrounds'.
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
            -- Turn on / off pipe table rendering.
            enabled = true,
            -- Additional modes to render pipe tables.
            render_modes = false,
            -- Pre configured settings largely for setting table border easier.
            -- | heavy  | use thicker border characters     |
            -- | double | use double line border characters |
            -- | round  | use round border corners          |
            -- | none   | does nothing                      |
            preset = "heavy",
            -- Determines how the table as a whole is rendered.
            -- | none   | disables all rendering                                                  |
            -- | normal | applies the 'cell' style rendering to each row of the table             |
            -- | full   | normal + a top & bottom line that fill out the table when lengths match |
            style = "full",
            -- Determines how individual cells of a table are rendered.
            -- | overlay | writes completely over the table, removing conceal behavior and highlights |
            -- | raw     | replaces only the '|' characters in each row, leaving the cells unmodified |
            -- | padded  | raw + cells are padded to maximum visual width for each column             |
            -- | trimmed | padded except empty space is subtracted from visual width calculation      |
            cell = "padded",
            -- Amount of space to put between cell contents and border.
            padding = 2,
            -- Minimum column width to use for padded or trimmed cell.
            min_width = 5,
            -- Characters used to replace table border.
            -- Correspond to top(3), delimiter(3), bottom(3), vertical, & horizontal.
            -- stylua: ignore
            border = {
                '┌', '┬', '┐',
                '├', '┼', '┤',
                '└', '┴', '┘',
                '│', '─',
            },
            -- Always use virtual lines for table borders instead of attempting to use empty lines.
            -- Will be automatically enabled if indentation module is enabled.
            border_virtual = false,
            -- Gets placed in delimiter row for each column, position is based on alignment.
            alignment_indicator = "━",
            -- Highlight for table heading, delimiter, and the line above.
            head = "RenderMarkdownTableHead",
            -- Highlight for everything else, main table rows and the line below.
            row = "RenderMarkdownTableRow",
            -- Highlight for inline padding used to add back concealed space.
            filler = "RenderMarkdownTableFill",
        },
    },
}
