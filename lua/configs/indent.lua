local M = {}

-- IndentBlankline setup
M.setup_indent_blankline = function()
	-- Set highlight group for indent lines
	vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#3b4261", nocombine = true })

	-- Keymap to toggle indent lines in current buffer
	vim.keymap.set("n", "<leader>ug", function()
		local buf = 0
		local config = require("ibl.config").get_config(buf)
		require("ibl").setup_buffer(buf, { enabled = not config.enabled })
	end, { desc = "Toggle indent lines" })

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
				"lazy",
				"mason",
				"notify",
				"snacks_dashboard",
				"snacks_notif",
				"snacks_terminal",
				"snacks_win",
				"toggleterm",
			},
		},
	})
end

-- Mini Indentscope setup
M.setup_mini_indentscope = function()
	require("mini.indentscope").setup({
		symbol = "│",
		options = {
			border = "both",
			indent_at_cursor = true,
			try_as_border = true,
		},
		draw = {
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
			"NvimTree",
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

-- Keymap for Telescope colorscheme picker with preview
vim.keymap.set("n", "<leader>th", function()
	require("telescope.builtin").colorscheme({ enable_preview = true })
end, { desc = "Telescope colorscheme with preview" })

return M
