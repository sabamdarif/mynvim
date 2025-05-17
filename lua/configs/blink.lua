return {
	snippets = {
		preset = "luasnip",
		-- Function to use when expanding LSP provided snippets
		-- expand = function(snippet)
		-- 	vim.snippet.expand(snippet)
		-- end,

		-- Function to use when checking if a snippet is active
		-- active = function(filter)
		-- 	return vim.snippet.active(filter)
		-- end,

		-- Function to use when jumping between tab stops in a snippet, where direction can be negative or positive
		-- jump = function(direction)
		-- 	vim.snippet.jump(direction)
		-- end,
	},
	-- All presets have the following mappings:
	-- C-space: Open menu or open docs if already open
	-- C-n/C-p or Up/Down: Select next/previous item
	-- C-e: Hide menu
	-- C-k: Toggle signature help (if signature.enabled = true)
	--
	-- See :h blink-cmp-config-keymap for defining your own keymap
	keymap = {
		preset = "enter",
		["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
		["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
	},
	appearance = {
		-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- Adjusts spacing to ensure icons are aligned
		nerd_font_variant = "mono",
	},
	-- (Default) Only show the documentation popup when manually triggered
	-- see:- https://cmp.saghen.dev/configuration/reference.html
	completion = {
		-- 'prefix' will fuzzy match on the text before the cursor
		-- 'full' will fuzzy match on the text before _and_ after the cursor
		-- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
		keyword = {
			-- 'prefix' will fuzzy match on the text before the cursor
			-- 'full' will fuzzy match on the text before _and_ after the cursor
			-- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
			range = "full",
		},
		trigger = {
			-- When true, will prefetch the completion items when entering insert mode
			prefetch_on_insert = true,

			-- When false, will not show the completion window automatically when in a snippet
			show_in_snippet = true,

			-- When true, will show the completion window after typing any of alphanumerics, `-` or `_`
			show_on_keyword = true,

			-- When true, will show the completion window after typing a trigger character
			show_on_trigger_character = true,
		},
		list = {
			-- Maximum number of items to display
			max_items = 200,

			selection = {
				-- When `true`, will automatically select the first item in the completion list
				preselect = true,
				-- preselect = function(ctx) return vim.bo.filetype ~= 'markdown' end,

				-- When `true`, inserts the completion item automatically when selecting it
				-- You may want to bind a key to the `cancel` command (default <C-e>) when using this option,
				-- which will both undo the selection and hide the completion menu
				auto_insert = true,
				-- auto_insert = function(ctx) return vim.bo.filetype ~= 'markdown' end
			},

			cycle = {
				-- When `true`, calling `select_next` at the _bottom_ of the completion list
				-- will select the _first_ completion item.
				from_bottom = true,
				-- When `true`, calling `select_prev` at the _top_ of the completion list
				-- will select the _last_ completion item.
				from_top = true,
			},
		},
		-- Disable auto brackets
		-- NOTE: some LSPs may add auto brackets themselves anyway
		accept = { auto_brackets = { enabled = true } },
		-- Show documentation when selecting a completion item
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
		-- Display a preview of the selected item on the current line
		ghost_text = { enabled = false },
	},

	-- Default list of enabled providers defined so that you can extend it
	-- elsewhere in your config, without redefining it, due to `opts_extend`
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		providers = {
			lsp = {
				name = "lsp",
				enabled = true,
				module = "blink.cmp.sources.lsp",
				min_keyword_length = 2,
				-- When linking markdown notes, I would get snippets and text in the
				-- suggestions, I want those to show only if there are no LSP
				-- suggestions
				--
				-- Enabled fallbacks as this seems to be working now
				-- Disabling fallbacks as my snippets wouldn't show up when editing
				-- lua files
				-- fallbacks = { "snippets", "buffer" },
				score_offset = 90, -- the higher the number, the higher the priority
			},
			path = {
				name = "Path",
				module = "blink.cmp.sources.path",
				score_offset = 25,
				-- When typing a path, I would get snippets and text in the
				-- suggestions, I want those to show only if there are no path
				-- suggestions
				fallbacks = { "snippets", "buffer" },
				-- min_keyword_length = 2,
				opts = {
					trailing_slash = false,
					label_trailing_slash = true,
					get_cwd = function(context)
						return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
					end,
					show_hidden_files_by_default = true,
				},
			},
			buffer = {
				name = "Buffer",
				enabled = true,
				max_items = 3,
				module = "blink.cmp.sources.buffer",
				min_keyword_length = 2,
				score_offset = 15, -- the higher the number, the higher the priority
			},
			snippets = {
				name = "snippets",
				enabled = true,
				max_items = 15,
				min_keyword_length = 2,
				module = "blink.cmp.sources.snippets",
				score_offset = 85, -- the higher the number, the higher the priority
			},
		},
		-- Define providers per filetype
		per_filetype = {
			-- optionally inherit from the `default` sources
			-- lua = { inherit_defaults = true, 'lsp', 'path' },
		},
	},
	fuzzy = {
		implementation = "prefer_rust",
		-- Frecency tracks the most recently/frequently used items and boosts the score of the item
		-- Note, this does not apply when using the Lua implementation.
		use_frecency = true,

		-- Proximity bonus boosts the score of items matching nearby words
		-- Note, this does not apply when using the Lua implementation.
		use_proximity = true,

		-- UNSAFE!! When enabled, disables the lock and fsync when writing to the frecency database. This should only be used on unsupported platforms (i.e. alpine termux)
		-- Note, this does not apply when using the Lua implementation.
		use_unsafe_no_lock = false,
	},
	cmdline = {
		enabled = true,
	},
	signature = { enabled = true },
}
