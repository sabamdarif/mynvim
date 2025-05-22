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
		build = ":MasonInstallAll",
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
			updateevents = "TextChanged,TextChangedI",
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
		version = "1.*",
		---@module 'blink.cmp'
		config = function(_, opts)
			require("blink.cmp").setup(opts)
		end,
		opts = function()
			return require("configs.blink")
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
		opts = function()
			return require("custom.conform")
		end,
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
		event = "VeryLazy",
		opts = require("configs.lualine"),
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
		event = { "BufReadPost", "BufNewFile" },
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
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			return require("configs.gitsigns")
		end,
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("diffview").setup({})
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
		lazy = false,
		priority = 1000,
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
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("scrollview").setup({
				excluded_filetypes = { "nerdtree", "NvimTree" },
				current_only = true,
				base = "right",
				column = 1,
				signs_on_startup = { "diagnostics", "search", "gitsigns" },
				diagnostics_severities = { vim.diagnostic.severity.ERROR },
			})
			require("scrollview.contrib.gitsigns").setup({
				show_in_folds = true,
				current_only = true,
				priority = 10,
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
	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			return require("configs.render-markdown")
		end,
	},
}
