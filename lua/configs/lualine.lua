return {
	options = {
		icons_enabled = true,
		theme = "auto",
		-- https://www.nerdfonts.com/cheat-sheet
		--            
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		always_divide_middle = true,
		globalstatus = true,
		disabled_filetypes = {
			statusline = { "alpha", "Avante" },
			winbar = {},
		},
	},
	sections = {
		lualine_a = {
			{ "mode", icon = "" },
		},
		lualine_b = {
			{ "filename", path = 0 },
		},
		lualine_c = {
			{ "branch", "diff" },
		},
		lualine_x = {
			{ "diagnostics", sources = { "nvim_diagnostic" } },
			{ "lsp_status", cond = hide_in_width, icon = " " },
			-- { "encoding", cond = hide_in_width },
			-- { "filetype", cond = hide_in_width },
		},
		lualine_y = {
			{
				function()
					return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
				end,
				icon = "󰉖",
			},
		},

		lualine_z = { "progress" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = { "fugitive", "nvim-tree" },
}
