local M = {}

-- IndentBlankline setup
M.setup_indent_blankline = function()
	vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#3b4261", nocombine = true })

	require("ibl").setup({
		indent = {
			char = "▏",
			highlight = "IndentBlanklineChar",
		},
		scope = { enabled = false },
		exclude = {
			filetypes = {
				"help",
				"startify",
				"dashboard",
				"packer",
				"neogitstatus",
				"NvimTree",
				"Trouble",
			},
		},
	})
end

-- Mini Indentscope setup
M.setup_mini_indentscope = function()
	require("mini.indentscope").setup({
		symbol = "│",
		options = {
			-- Type of scope's border: which line(s) with smaller indent to
			-- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
			border = "both",
			-- Whether to use cursor column when computing reference indent.
			-- Useful to see incremental scopes with horizontal cursor movements.
			indent_at_cursor = true,
			-- Whether to first check input line to be a border of adjacent scope.
			-- Use it if you want to place cursor on function header to get scope of
			-- its body.
			try_as_border = true,
		},
		draw = {
			-- Delay (in ms) between event and start of drawing scope indicator
			delay = 700,
		},
	})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = {
			"Trouble",
			"alpha",
			"dashboard",
			"fzf",
			"help",
			"lazy",
			"mason",
			-- "NvimTree",
			"notify",
			"snacks_dashboard",
			"snacks_notif",
			"snacks_terminal",
			"snacks_win",
			"toggleterm",
			"trouble",
		},
		callback = function()
			vim.b.miniindentscope_disable = true
		end,
	})
end

return M
