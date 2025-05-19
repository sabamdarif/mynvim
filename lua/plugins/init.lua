return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		config = function()
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
	},
	{
		"onsails/lspkind.nvim",
		lazy = true,
	},
	{
		"nvim-lua/plenary.nvim",
	},
	{
		"nvim-tree/nvim-tree.lua",
		priority = 1000,
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		opts = function()
			return require("configs.nvimtree")
		end,
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonInstallAll" },
		opts = function()
			return require("configs.mason")
		end,
		config = function(_, opts)
			require("mason").setup(opts)
			-- Load the auto-installer module
			require("configs.mason-autoinstall")
		end,
	},
	--	blink.cmp configuration
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			{
				"rafamadriz/friendly-snippets",
				config = function()
					-- VSCode-format snippets
					require("luasnip.loaders.from_vscode").lazy_load()

					-- Your custom snippets (VSCode format)
					-- require("luasnip.loaders.from_vscode").lazy_load({
					-- 	paths = { vim.fn.stdpath("config") .. "/snippets" },
					-- })
				end,
			},
		},
		opts = {
			history = true,
			-- updateevents = "TextChanged,TextChangedI",
			delete_check_events = "TextChanged",
		},
	},

	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"mikavilpas/blink-ripgrep.nvim",
		},
		opts = function()
			return require("configs.blink")
		end,
		config = function(_, opts)
			require("blink.cmp").setup(opts)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("configs.lspconfig")
		end,
	},
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = require("custom.conform"),
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		cmd = "Telescope",
		opts = function()
			return require("configs.telescope")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VimEnter",
		opts = function()
			return require("configs.lualine")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = function()
			return require("custom.treesitter")
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = true,
		config = function()
			require("configs.treesitter-textobjects")()
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("configs.indent").setup_indent_blankline()
		end,
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("configs.indent").setup_mini_indentscope()
		end,
	},
	{
		"akinsho/bufferline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"moll/vim-bbye",
			"nvim-tree/nvim-web-devicons",
		},
		opts = function()
			return require("configs.bufferline")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "User FilePost",
		opts = function()
			return require("configs.gitsigns")
		end,
	},
	{
		"MagicDuck/grug-far.nvim",
		config = function(_, opts)
			require("grug-far").setup(opts)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "grug-far",
				callback = function()
					vim.keymap.set({ "i", "n" }, "<Esc>", "<Cmd>stopinsert | bd!<CR>", { buffer = true })
				end,
			})
		end,
	},
	{
		"brenton-leighton/multiple-cursors.nvim",
		version = "*",
		opts = function()
			return require("configs.multiple-cursors").opts
		end,
		keys = require("configs.multiple-cursors").keys,
	},
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			{
				"folke/persistence.nvim",
				event = "BufReadPre",
				opts = {
					options = { "buffers", "curdir", "tabpages", "winsize" },
				},
			},
		},
		config = function()
			require("configs.dashboard").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = function()
			return require("configs.noice")
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		enabled = false,
	},
	{
		"CRAG666/code_runner.nvim",
		cmd = {
			"RunCode",
			"RunFile",
			"RunProject",
			"RunClose",
			"CRFiletype",
			"CRProjects",
		},
		config = function()
			require("custom.code-runner").setup()
		end,
	},
	{
		"dstein64/nvim-scrollview",
		event = "WinScrolled",
		config = function()
			require("scrollview").setup({
				excluded_filetypes = { "nerdtree" },
				current_only = true,
				base = "right",
				column = 1,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			return require("configs.treesitter-context")
		end,
	},

	------------------------------------------------------
	---------        External plugins    -----------------
	------------------------------------------------------
	{ "nvzone/volt", lazy = false },
	{
		"nvzone/menu",
		keys = {
			{ "<C-t>", mode = "n" },
			{ "<RightMouse>", mode = { "n", "v" } },
		},
		config = function()
			-- Keyboard users
			vim.keymap.set("n", "<C-t>", function()
				require("menu").open("default")
			end, {})

			-- mouse users + nvimtree users!
			vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
				require("menu.utils").delete_old_menus()

				vim.cmd.exec('"normal! \\<RightMouse>"')

				-- clicked buf
				local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
				local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

				require("menu").open(options, { mouse = true })
			end, {})
		end,
	},
	{
		"nvzone/minty",
		cmd = { "Shades", "Huefy" },
	},
	{
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
		config = function(_, opts)
			-- core setup
			require("neoscroll").setup(opts)
		end,
		opts = {
			mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
			easing_function = "cubic",
			hide_cursor = true,
			stop_eof = true,
			respect_scrolloff = true,
		},
	},
	{
		"tzachar/local-highlight.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("local-highlight").setup({
				file_types = {}, -- disable default auto-attach
				hlgroup = "LocalHighlight",
				cw_hlgroup = nil,
				insert_mode = false,
				min_match_len = 1,
				highlight_single_match = true,
				animate = { enabled = false }, -- disable snack animation
				debounce_timeout = 200,
			})

			-- Visual mode enter
			vim.api.nvim_create_autocmd("ModeChanged", {
				pattern = "*:[vV\x16]*",
				callback = function()
					vim.cmd("LocalHighlightOn")
				end,
			})

			-- Visual mode exit
			vim.api.nvim_create_autocmd("ModeChanged", {
				pattern = "[vV\x16]*:*",
				callback = function()
					vim.cmd("LocalHighlightOff")
				end,
			})
		end,
	},
}
