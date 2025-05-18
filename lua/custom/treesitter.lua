---@type TSConfig
return {
	highlight = { enable = true },
	indent = { enable = true },
	ensure_installed = {
		"bash",
		"awk",
		"lua",
		"luadoc",
		"markdown",
		"toml",
		"vim",
		"vimdoc",
		"yaml",
		"html",
		"css",
		"javascript",
		"python",
		"regex",
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},
	textobjects = {},
}
