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
			{
				"filetype",
				colored = true,
				icon_only = true,
				separator = "",
				icon = { align = "right" },
				padding = { left = 1, right = 0 },
			},
			{
				"filename",
				path = 0,
				file_status = true,
				padding = { left = 0, right = 0 },
				icon_enabled = false,
				symbols = {
					modified = "[●]",
					readonly = "[-]",
					unnamed = "[No Name]",
					newfile = "[New]",
				},
			},
		},
		lualine_c = {
			{ "branch", "diff" },
			{
				"searchcount",
				maxcount = 999,
				timeout = 500,
			},
		},
		lualine_x = {
			{ "diagnostics", sources = { "nvim_diagnostic" } },
			{
				"lsp_status",
				icon = " ",
				symbols = {
					-- Standard unicode symbols to cycle through for LSP progress:
					spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
					-- Standard unicode symbol for when LSP is done:
					done = "✓",
					-- Delimiter inserted between LSP names:
					separator = " ",
				},
				-- List of LSP names to ignore (e.g., `null-ls`):
				ignore_lsp = {},
			},
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
	extensions = { "fugitive", "nvim-tree", "lazy", "mason" },
}
