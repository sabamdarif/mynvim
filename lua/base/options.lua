local o = vim.o
local opt = vim.opt

-- UI
o.laststatus = 3
o.showmode = false
o.termguicolors = true
o.cursorline = true
o.cursorlineopt = "both"
o.number = true
o.numberwidth = 2
o.ruler = false
o.signcolumn = "yes"
o.pumblend = 10
o.pumheight = 10
o.scrolloff = 4
o.sidescrolloff = 8
o.smoothscroll = true
o.winborder = "rounded"
opt.fillchars = { eob = " " }
opt.shortmess:append({ s = true, I = true, W = true, c = true, C = true })

-- Invisible characters. `leadmultispace` draws the static indent guides;
-- mini.indentscope draws the active one and turns both off where they'd be noise.
o.list = true
opt.listchars = { tab = ". ", trail = "_", nbsp = "␣", leadmultispace = "▏   " }

-- Indentation: 4 spaces, .editorconfig wins where a project has one
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.smartindent = true

-- Search / grep
o.ignorecase = true
o.smartcase = true
o.inccommand = "nosplit"
o.grepprg = "rg --vimgrep"
o.grepformat = "%f:%l:%c:%m"

-- Editing
o.mouse = "a"
o.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
o.confirm = true -- prompt instead of failing when abandoning an unsaved buffer
o.showmatch = true
o.splitkeep = "screen"
o.undofile = true
o.undolevels = 500
o.virtualedit = "block"
o.jumpoptions = "view"
o.wildmode = "longest:full,full"
o.formatoptions = "jcroqlnt"
o.wrap = true

-- Folding: treesitter everywhere, swapped for the LSP's own ranges where a
-- server offers foldingRange (see plugins/lspconfig.lua). Both expressions
-- return 0 when unavailable, so a buffer with no parser just gets no folds.
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldlevel = 99
o.foldtext = "" -- keep syntax highlighting on the folded line

-- Per-project .nvim.lua, with a trust prompt
o.exrc = true
o.secure = true
vim.g.editorconfig = true
