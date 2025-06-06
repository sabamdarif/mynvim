---@type TSConfig
return {
	highlight = { enable = true },
	indent = { enable = true },
	ensure_installed = {
		"bash",
		"c",
		"awk",
		"lua",
		"luadoc",
		"luap",
		"markdown",
		"markdown_inline",
		"toml",
		"vim",
		"vimdoc",
		"yaml",
		"html",
		"css",
		"javascript",
		"python",
		"diff",
		"json",
		"regex",
		"xml",
		"latex",
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
