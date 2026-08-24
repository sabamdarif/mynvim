return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        signs = {
            add = { text = "▎" },
            delete = { text = "󰍵" },
            changedelete = { text = "󱕖" },
            untracked = { text = "│" },
        },
        signs_staged = {
            add = { text = "▎" },
            delete = { text = "󰍵" },
            changedelete = { text = "󱕖" },
        },
    },
}
