return {
	opts = {},
	keys = {
		{
			"<C-S-l>",
			"<Cmd>MultipleCursorsAddMatches<CR>",
			mode = { "n", "x" },
			desc = "Select all matches (VSCode Ctrl+Shift+L)",
		},
		{
			"<C-d>",
			"<Cmd>MultipleCursorsAddNextMatch<CR>",
			mode = { "n", "x" },
			desc = "Select next occurrence (VSCode Ctrl+D)",
		},
		{
			"<C-k><C-d>",
			"<Cmd>MultipleCursorsSkipAndAddNext<CR>",
			mode = { "n", "x" },
			desc = "Skip & select next (VSCode Ctrl+K Ctrl+D)",
		},
		{
			"<C-j>",
			"<Cmd>MultipleCursorsAddDown<CR>",
			mode = { "n", "x" },
			desc = "Add cursor & move down",
		},
		{
			"<C-k>",
			"<Cmd>MultipleCursorsAddUp<CR>",
			mode = { "n", "x" },
			desc = "Add cursor & move up",
		},
		{
			"<C-Up>",
			"<Cmd>MultipleCursorsAddUp<CR>",
			mode = { "n", "i", "x" },
			desc = "Add cursor & move up",
		},
		{
			"<C-Down>",
			"<Cmd>MultipleCursorsAddDown<CR>",
			mode = { "n", "i", "x" },
			desc = "Add cursor & move down",
		},
		{
			"<C-LeftMouse>",
			"<Cmd>MultipleCursorsMouseAddDelete<CR>",
			mode = { "n", "i" },
			desc = "Toggle cursor at mouse",
		},
		{
			"<Leader>m",
			"<Cmd>MultipleCursorsAddVisualArea<CR>",
			mode = "x",
			desc = "Add cursors to visual area",
		},
		{
			"<Leader>a",
			"<Cmd>MultipleCursorsAddMatches<CR>",
			mode = { "n", "x" },
			desc = "Add cursors to word under cursor",
		},
		{
			"<Leader>l",
			"<Cmd>MultipleCursorsLock<CR>",
			mode = { "n", "x" },
			desc = "Lock virtual cursors",
		},
	},
}
