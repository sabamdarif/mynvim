-- based on https://github.com/linkarzu/dotfiles-latest/blob/main/neovim/neobean/lua/plugins/render-markdown.lua

-- Function to get colors dynamically from current theme
local function get_theme_colors()
	local colors = {}

	-- Try to get colors from various highlight groups
	local function get_hl_color(group, attr)
		local hl = vim.api.nvim_get_hl(0, { name = group })
		if attr == "fg" then
			return hl.fg and string.format("#%06x", hl.fg) or nil
		elseif attr == "bg" then
			return hl.bg and string.format("#%06x", hl.bg) or nil
		end
	end

	-- Define fallback color palette (works with most themes)
	local fallbacks = {
		-- Background colors for headings (lighter variants)
		bg1 = "#fb4934", -- Red
		bg2 = "#b8bb26", -- Green
		bg3 = "#fabd2f", -- Yellow
		bg4 = "#83a598", -- Blue
		bg5 = "#d3869b", -- Purple
		bg6 = "#8ec07c", -- Cyan

		-- Foreground colors (darker for readability)
		fg1 = "#1d2021", -- Dark for red bg
		fg2 = "#1d2021", -- Dark for green bg
		fg3 = "#1d2021", -- Dark for yellow bg
		fg4 = "#1d2021", -- Dark for blue bg
		fg5 = "#1d2021", -- Dark for purple bg
		fg6 = "#1d2021", -- Dark for cyan bg

		-- Normal text
		normal_fg = "#ebdbb2",
		normal_bg = "#282828",

		-- Code inline
		code_bg = "#3c3836",
		code_fg = "#fe8019",
	}

	-- Try to get theme-specific colors, fallback to defaults
	colors.normal_bg = get_hl_color("Normal", "bg") or fallbacks.normal_bg
	colors.normal_fg = get_hl_color("Normal", "fg") or fallbacks.normal_fg

	-- Get accent colors from different highlight groups
	colors.red = get_hl_color("DiagnosticError", "fg") or get_hl_color("ErrorMsg", "fg") or fallbacks.bg1
	colors.green = get_hl_color("DiagnosticOk", "fg") or get_hl_color("String", "fg") or fallbacks.bg2
	colors.yellow = get_hl_color("DiagnosticWarn", "fg") or get_hl_color("Warning", "fg") or fallbacks.bg3
	colors.blue = get_hl_color("DiagnosticInfo", "fg") or get_hl_color("Function", "fg") or fallbacks.bg4
	colors.purple = get_hl_color("DiagnosticHint", "fg") or get_hl_color("Keyword", "fg") or fallbacks.bg5
	colors.cyan = get_hl_color("DiagnosticHint", "fg") or get_hl_color("Type", "fg") or fallbacks.bg6

	-- Code highlighting
	colors.code_bg = get_hl_color("CursorLine", "bg") or fallbacks.code_bg
	colors.code_fg = get_hl_color("Constant", "fg") or fallbacks.code_fg

	return colors
end

-- Setup highlight groups
local function setup_highlights()
	local colors = get_theme_colors()

	-- Check if transparent backgrounds are preferred
	local transparent_bg = vim.g.md_heading_bg == "transparent"

	if transparent_bg then
		-- For transparent mode: use background colors as foreground (text color)
		-- and set background to match normal background or transparent
		local heading_configs = {
			{ fg = colors.red, bg = colors.normal_bg },
			{ fg = colors.green, bg = colors.normal_bg },
			{ fg = colors.yellow, bg = colors.normal_bg },
			{ fg = colors.blue, bg = colors.normal_bg },
			{ fg = colors.purple, bg = colors.normal_bg },
			{ fg = colors.cyan, bg = colors.normal_bg },
		}

		for i = 1, 6 do
			-- Background highlight (for the heading text area)
			vim.api.nvim_set_hl(0, "Headline" .. i .. "Bg", {
				fg = heading_configs[i].fg,
				bg = heading_configs[i].bg,
			})
			-- Foreground highlight (for icons and signs)
			vim.api.nvim_set_hl(0, "Headline" .. i .. "Fg", {
				fg = heading_configs[i].fg,
				bold = true,
			})
		end
	else
		-- For colored backgrounds: use bright colors as background with dark text
		local heading_configs = {
			{ fg = "#1d2021", bg = colors.red },
			{ fg = "#1d2021", bg = colors.green },
			{ fg = "#1d2021", bg = colors.yellow },
			{ fg = "#1d2021", bg = colors.blue },
			{ fg = "#1d2021", bg = colors.purple },
			{ fg = "#1d2021", bg = colors.cyan },
		}

		for i = 1, 6 do
			-- Background highlight (colored background with dark text for readability)
			vim.api.nvim_set_hl(0, "Headline" .. i .. "Bg", {
				fg = heading_configs[i].fg,
				bg = heading_configs[i].bg,
			})
			-- Foreground highlight (for icons, using the same color as background)
			vim.api.nvim_set_hl(0, "Headline" .. i .. "Fg", {
				fg = heading_configs[i].bg,
				bold = true,
			})
		end
	end

	-- Inline code highlighting
	vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", {
		fg = colors.code_fg,
		bg = colors.code_bg,
	})

	-- Table highlighting
	vim.api.nvim_set_hl(0, "RenderMarkdownTableHead", {
		fg = colors.normal_fg,
		bg = colors.code_bg,
		bold = true,
	})
	vim.api.nvim_set_hl(0, "RenderMarkdownTableRow", {
		fg = colors.normal_fg,
	})
	vim.api.nvim_set_hl(0, "RenderMarkdownTableFill", {
		fg = colors.blue,
	})
end

-- Auto-setup highlights when colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("RenderMarkdownHighlights", { clear = true }),
	callback = setup_highlights,
})

-- Setup highlights immediately
setup_highlights()

-- Return the plugin configuration
return {
	bullet = {
		enabled = true,
	},
	checkbox = {
		enabled = true,
		position = "inline",
		unchecked = {
			icon = "   󰄱 ",
			highlight = "RenderMarkdownUnchecked",
			scope_highlight = nil,
		},
		checked = {
			icon = "   󰱒 ",
			highlight = "RenderMarkdownChecked",
			scope_highlight = nil,
		},
	},
	html = {
		enabled = true,
		comment = {
			conceal = false,
		},
	},
	link = {
		-- Adjust icon based on your preference or terminal capabilities
		image = "󰥶 ",
		custom = {
			youtu = { pattern = "youtu%.be", icon = "󰗃 " },
		},
	},
	heading = {
		sign = false,
		-- Only color the text width, not entire line
		width = "block", -- This ensures only the heading text gets colored, not the full line
		icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
		backgrounds = {
			"Headline1Bg",
			"Headline2Bg",
			"Headline3Bg",
			"Headline4Bg",
			"Headline5Bg",
			"Headline6Bg",
		},
		foregrounds = {
			"Headline1Fg",
			"Headline2Fg",
			"Headline3Fg",
			"Headline4Fg",
			"Headline5Fg",
			"Headline6Fg",
		},
	},
}
