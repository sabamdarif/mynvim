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
		menu = {
			draw = {
				components = {
					kind_icon = {
						text = function(ctx)
							local icon = ctx.kind_icon
							if vim.tbl_contains({ "Path" }, ctx.source_name) then
								local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
								if dev_icon then
									icon = dev_icon
								end
							else
								icon = require("lspkind").symbolic(ctx.kind, {
									mode = "symbol",
								})
							end

							return icon .. ctx.icon_gap
						end,
					},
				},
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind_icon", "kind", gap = 1 },
				},
			},
			scrollbar = false,
			border = nil, -- "single", "rounded"
			auto_show = true,
		},
		list = {
			-- Maximum number of items to display
			max_items = 200,
		},
		-- Show documentation when selecting a completion item
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 100,
			-- window = { border = "single" },
		},
		-- Display a preview of the selected item on the current line
		ghost_text = {
			enabled = true,
			show_with_menu = true,
		},
	},

	-- Default list of enabled providers defined so that you can extend it
	-- elsewhere in your config, without redefining it, due to `opts_extend`
	sources = {
		default = { "lsp", "snippets", "buffer", "ripgrep", "path" },
		providers = {
			lsp = {
				name = "lsp",
				enabled = true,
				module = "blink.cmp.sources.lsp",
				min_keyword_length = 1, -- Show completion after typing 1 character
				-- When linking markdown notes, I would get snippets and text in the
				-- suggestions, I want those to show only if there are no LSP
				-- suggestions
				--
				-- Enabled fallbacks as this seems to be working now
				-- Disabling fallbacks as my snippets wouldn't show up when editing
				-- lua files
				-- fallbacks = { "snippets", "buffer" },
				score_offset = 100, -- the higher the number, the higher the priority
			},
			snippets = {
				name = "snippets",
				enabled = true,
				max_items = 15,
				min_keyword_length = 1, -- Show completion after typing 1 character
				module = "blink.cmp.sources.snippets",
				score_offset = 95, -- Higher than buffer
			},
			buffer = {
				name = "Buffer",
				enabled = true,
				max_items = 3,
				module = "blink.cmp.sources.buffer",
				min_keyword_length = 1, -- Show completion after typing 1 character
				score_offset = 90, -- Lower than snippets
			},
			ripgrep = {
				module = "blink-ripgrep",
				name = "Ripgrep",
				score_offset = 85, -- Lower than buffer
				opts = {
					-- the minimum length of the current word to start searching
					-- (if the word is shorter than this, the search will not start)
					prefix_min_len = 5,
				},
			},
			path = {
				name = "Path",
				module = "blink.cmp.sources.path",
				score_offset = 80, -- Lowest priority as requested
				-- When typing a path, I would get snippets and text in the
				-- suggestions, I want those to show only if there are no path
				-- suggestions
				fallbacks = { "snippets", "buffer" },
				min_keyword_length = 2, -- Show completion after typing 2 character
				opts = {
					trailing_slash = false,
					label_trailing_slash = true,
					get_cwd = function(context)
						return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
					end,
					show_hidden_files_by_default = true,
				},
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
		-- exact: Sorts by exact match, case-sensitive
		-- score: Sorts by the fuzzy matching score
		-- sort_text: Sorts by the sortText field
		-- ----Generally, this field provides better sorting than label as the source/LSP may prioritize items relevant to the current context
		-- ----If you're writing your own source, use this field to control sort order, instead of requiring users to add a sort function
		-- label: Sorts by the label field, deprioritizing entries with a leading
		-- kind: Sorts by the numeric kind field
		sorts = {
			"exact",
			"score",
			"sort_text",
		},
	},
	cmdline = {
		enabled = true,
	},
	signature = { enabled = true },
}
