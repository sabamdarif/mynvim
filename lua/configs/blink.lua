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
						-- Optionally, use the highlight groups from nvim-web-devicons
						-- You can also add the same function for `kind.highlight` if you want to
						-- keep the highlight groups in sync with the icons.
						-- highlight = function(ctx)
						-- 	local hl = ctx.kind_hl
						-- 	if vim.tbl_contains({ "Path" }, ctx.source_name) then
						-- 		local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
						-- 		if dev_icon then
						-- 			hl = dev_hl
						-- 		end
						-- 	end
						-- 	return hl
						-- end,
						highlight = function(ctx)
							return { { group = ctx.kind_hl } }
						end,
					},
				},
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind_icon", "kind", gap = 1 },
				},
				treesitter = {
					"lsp",
				},
			},
			scrollbar = false,
			border = nil, -- "single", "rounded"
			auto_show = true,
		},
		-- 'prefix' will fuzzy match on the text before the cursor
		-- 'full' will fuzzy match on the text before _and_ after the cursor
		-- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
		keyword = {
			-- 'prefix' will fuzzy match on the text before the cursor
			-- 'full' will fuzzy match on the text before _and_ after the cursor
			-- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
			range = "prefix",
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
				min_keyword_length = 2,
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
				min_keyword_length = 2,
				module = "blink.cmp.sources.snippets",
				score_offset = 95, -- Higher than buffer
			},
			buffer = {
				name = "Buffer",
				enabled = true,
				max_items = 3,
				module = "blink.cmp.sources.buffer",
				min_keyword_length = 2,
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
					-- The number of lines to show around each match in the preview
					-- (documentation) window. For example, 5 means to show 5 lines
					-- before, then the match, and another 5 lines after the match.
					context_size = 5,
					-- The maximum file size of a file that ripgrep should include in
					-- its search. Useful when your project contains large files that
					-- might cause performance issues.
					-- Examples:
					-- "1024" (bytes by default), "200K", "1M", "1G", which will
					-- exclude files larger than that size.
					max_filesize = "1M",
					-- Specifies how to find the root of the project where the ripgrep
					-- search will start from. Accepts the same options as the marker
					-- given to `:h vim.fs.root()` which offers many possibilities for
					-- configuration. If none can be found, defaults to Neovim's cwd.
					--
					-- Examples:
					-- - ".git" (default)
					-- - { ".git", "package.json", ".root" }
					project_root_marker = ".git",
					-- Enable fallback to neovim cwd if project_root_marker is not
					-- found. Default: `true`, which means to use the cwd.
					project_root_fallback = true,
					-- The casing to use for the search in a format that ripgrep
					-- accepts. Defaults to "--ignore-case". See `rg --help` for all the
					-- available options ripgrep supports, but you can try
					-- "--case-sensitive" or "--smart-case".
					search_casing = "--smart-case",
					-- (advanced) Any additional options you want to give to ripgrep.
					-- See `rg -h` for a list of all available options. Might be
					-- helpful in adjusting performance in specific situations.
					-- If you have an idea for a default, please open an issue!
					--
					-- Not everything will work (obviously).
					additional_rg_options = {},
					-- When a result is found for a file whose filetype does not have a
					-- treesitter parser installed, fall back to regex based highlighting
					-- that is bundled in Neovim.
					fallback_to_regex_highlighting = true,
					-- Absolute root paths where the rg command will not be executed.
					-- Usually you want to exclude paths using gitignore files or
					-- ripgrep specific ignore files, but this can be used to only
					-- ignore the paths in blink-ripgrep.nvim, maintaining the ability
					-- to use ripgrep for those paths on the command line. If you need
					-- to find out where the searches are executed, enable `debug` and
					-- look at `:messages`.
					ignore_paths = {},
					-- Any additional paths to search in, in addition to the project
					-- root. This can be useful if you want to include dictionary files
					-- (/usr/share/dict/words), framework documentation, or any other
					-- reference material that is not available within the project
					-- root.
					additional_paths = {},
					-- Keymaps to toggle features on/off. This can be used to alter
					-- the behavior of the plugin without restarting Neovim. Nothing
					-- is enabled by default. Requires folke/snacks.nvim.
					toggles = {
						on_off = nil,
					},
					-- Features that are not yet stable and might change in the future.
					-- You can enable these to try them out beforehand, but be aware
					-- that they might change. Nothing is enabled by default.
					future_features = {
						backend = {
							-- The backend to use for searching. Defaults to "ripgrep".
							-- Available options:
							-- - "ripgrep", always use ripgrep
							-- - "gitgrep", always use git grep
							-- - "gitgrep-or-ripgrep", use git grep if possible, otherwise
							--   ripgrep
							use = "ripgrep",
						},
					},
					-- Show debug information in `:messages` that can help in
					-- diagnosing issues with the plugin.
					debug = false,
				},
				-- (optional) customize how the results are displayed. Many options
				-- are available - make sure your lua LSP is set up so you get
				-- autocompletion help
				transform_items = function(_, items)
					for _, item in ipairs(items) do
						-- example: append a description to easily distinguish rg results
						item.labelDetails = {
							description = "(rg)",
						}
					end
					return items
				end,
			},
			path = {
				name = "Path",
				module = "blink.cmp.sources.path",
				score_offset = 80, -- Lowest priority as requested
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
		},
		-- Define providers per filetype
		per_filetype = {
			-- optionally inherit from the `default` sources
			-- lua = { inherit_defaults = true, 'lsp', 'path' },
		},
	},
	fuzzy = {
		implementation = "prefer_rust_with_warning",
		-- Frecency tracks the most recently/frequently used items and boosts the score of the item
		-- Note, this does not apply when using the Lua implementation.
		use_frecency = true,
		-- Proximity bonus boosts the score of items matching nearby words
		-- Note, this does not apply when using the Lua implementation.
		use_proximity = true,
		-- UNSAFE!! When enabled, disables the lock and fsync when writing to the frecency database. This should only be used on unsupported platforms (i.e. alpine termux)
		-- Note, this does not apply when using the Lua implementation.
		use_unsafe_no_lock = false,

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
