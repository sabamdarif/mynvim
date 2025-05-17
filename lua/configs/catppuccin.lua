return {
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	background = {
		light = "latte",
		dark = "mocha",
	},
	transparent_background = false,
	show_end_of_buffer = false,
	term_colors = false,
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.15,
	},
	integrations = {
		cmp = true,
		blink_cmp = true,
		gitsigns = true,
		nvimtree = true,
		treesitter = true,
		notify = true,
		grug_far = true,
		mason = true,
		indent_blankline = {
			enabled = true,
			scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
			colored_indent_levels = true,
		},
		treesitter_context = true,
		which_key = false,
	},
}
