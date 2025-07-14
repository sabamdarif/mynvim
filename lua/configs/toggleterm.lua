return {
	size = 10, -- size can be a number or function which is passed the current terminal
	open_mapping = [[<C-\>]],
	hide_numbers = true, -- hide the number column in toggleterm buffers
	shade_terminals = true,
	shading_factor = 2, -- the percentage by which to lighten dark terminal background, default: -30
	start_in_insert = true,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
	persist_size = true,
	direction = "horizontal", -- 'vertical' | 'horizontal' | 'tab' | 'float',
	close_on_exit = true, -- close the terminal window when the process exits
	auto_scroll = true, -- automatically scroll to the bottom on terminal output
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 3,
	},
}
