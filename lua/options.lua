local opt = vim.opt
local o = vim.o
local g = vim.g

-------------------------------------- options ------------------------------------------
o.laststatus = 3
o.showmode = false

o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "both"

-- Indenting
o.shiftwidth = 4 -- Indent width
o.tabstop = 4 -- Tab width
o.softtabstop = 4 -- Soft tab stop
o.expandtab = true
o.smartindent = true
o.autoindent = true

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true
o.numberwidth = 2
o.ruler = false

-- disable nvim intro
opt.shortmess:append("sI")

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.undofile = true
-- Time (in milliseconds) that Neovim waits for you to complete a mapped key sequence
-- Decrease from default 1000ms
o.timeoutlen = 500
-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 500

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")
opt.autoread = true -- Auto reload files changed outside vim
opt.showmatch = true -- Highlight matching brackets
-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has("win32") ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, sep) .. delim .. vim.env.PATH
