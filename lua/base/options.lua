local opt = vim.opt
local o = vim.o
local g = vim.g

-------------------------------------- UI ------------------------------------------
o.laststatus = 3
o.showmode = false
opt.termguicolors = true
opt.cursorline = true
o.cursorlineopt = "both"
opt.fillchars = { eob = " " }
opt.signcolumn = "yes"
o.ruler = false
opt.number = true
opt.numberwidth = 2
opt.pumblend = 10
opt.pumheight = 10
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.list = true -- Show invisible characters like tabs/spaces
opt.listchars = { -- Customize symbols for invisible characters
    tab = ". ", -- Tabs shown as ▸
    trail = "_", -- Trailing spaces shown as ·
    nbsp = "␣", -- Non-breaking space shown as ␣
}
opt.wrap = true
opt.winminwidth = 5

-------------------------------------- Clipboard -----------------------------------
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

-------------------------------------- Indentation ---------------------------------
o.shiftwidth = 4     -- Indent width
o.tabstop = 4        -- Tab width
o.softtabstop = 4    -- Soft tab stop
o.expandtab = true   -- Convert tabs to spaces
o.smartindent = true -- Automatically inserts indents in some contexts
o.autoindent = true  -- Copy indent from previous line

-------------------------------------- Search --------------------------------------
o.ignorecase = true -- Ignore case when searching --> Example: /hello matches "Hello" or "HELLO".

-------------------------------------- Mouse ---------------------------------------
o.mouse = "a"

-------------------------------------- Splits --------------------------
opt.splitkeep = "screen" -- Cursor stays visually in place when split opens.

-------------------------------------- Undo / History ----------------------------
opt.undofile = true  -- Save undo history to file
opt.undolevels = 100 -- Maximum number of undos

-------------------------------------- Folding -------------------------------------
opt.foldmethod = "indent"
opt.foldlevel = 99

-------------------------------------- Editor behavior ---------------------------
opt.formatoptions =
"jcroqlnt" -- Control formatting behaviour --> Example: Auto-wrap comments, remove trailing spaces, etc.
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.inccommand = "nosplit"
opt.jumpoptions = "view"
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.showmatch = true -- Highlight matching brackets
opt.confirm = true   -- Ask before closing unsaved files
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.smoothscroll = true
opt.spelllang = { "en" }
opt.shortmess:append({ s = true, I = true, W = true, c = true, C = true })

-------------------------------------- File safety (local config) ---------------------------------
o.exrc = true         -- It will allow to use project's local .nvim.lua file
o.secure = true       -- Ask you if you want to trust project's .nvim.lua file
g.editorconfig = true -- To make Neovim respect your .editorconfig settings
