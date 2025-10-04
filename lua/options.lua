local opt = vim.opt
local o = vim.o
local g = vim.g

-- UI
o.laststatus = 3 -- Show a single global status line (instead of one per window)
-- Example: One status line at the bottom no matter how many splits.

o.showmode = false -- Don’t show the mode (like -- INSERT --) because your statusline shows it
-- Example: No "-- INSERT --" at the bottom.

o.exrc = true -- Allow Neovim to read project-local config files
-- Example: It will allow to use project's local .nvim.lua file

o.secure = true -- For safety: disables risky commands in local files
-- Example: Ask you if you want to trust project's .nvim.lua file

opt.termguicolors = true -- Enable true color support
-- Example: Your colorschemes will look better with full RGB colors.

opt.cursorline = true -- Highlight the current line
-- Example: The line your cursor is on will be visually highlighted.

o.cursorlineopt = "both" -- Highlight both the line and the screen column of the cursor
-- Example: Cursor column also highlighted for easy navigation.

opt.fillchars = { eob = " " } -- Replace end-of-buffer ~ with spaces
-- Example: Empty lines at the end of a file are blank instead of showing ~.

opt.signcolumn = "yes" -- Always show the sign column
-- Example: No text shifting when LSP or Git signs appear.

opt.ruler = false -- Disable the default ruler in the statusline
-- Example: Line/column info is not shown because your statusline handles it.

opt.number = true -- Show line numbers
-- Example: Line 1, 2, 3 ... are displayed.

opt.numberwidth = 2 -- Minimum width of line numbers
-- Example: Space for 2-digit line numbers; avoids shifting.

opt.pumblend = 10 -- Make popup menu slightly transparent
-- Example: Completion menu blends with background slightly.

opt.pumheight = 10 -- Maximum number of entries in popup menu
-- Example: Completion menu will show up to 10 items.

opt.scrolloff = 4 -- Keep 4 lines visible above/below cursor when scrolling
-- Example: Cursor never touches the screen edge when moving.

opt.sidescrolloff = 8 -- Keep 8 columns visible left/right of cursor
-- Example: Horizontal scroll shows context around cursor.


opt.list = true -- Show invisible characters like tabs/spaces

opt.listchars = { -- Customize symbols for invisible characters
    tab = ". ", -- Tabs shown as ▸
    trail = "_", -- Trailing spaces shown as ·
    nbsp = "␣", -- Non-breaking space shown as ␣
}
-- Example: Tabs and spaces become visible, useful for coding alignment.

opt.wrap = true -- Enable line wrap
-- Example: Text that exceeds the screen width will continue on the next line.

opt.winminwidth = 5 -- Minimum width for a window
-- Example: Prevents splits from becoming too small.

-- Clipboard (respect remote SSH terminals)
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
-- Example: Local clipboard works normally, but remote SSH disables system clipboard.

-- Indentation
opt.shiftwidth = 4 -- Number of spaces for indentation commands (>>, <<)
-- Example: Pressing >> indents 2 spaces.

opt.tabstop = 4 -- How many spaces a tab counts for
-- Example: A literal tab character displays as 2 spaces wide.

opt.softtabstop = 4 -- Number of spaces a Tab key press inserts in insert mode
-- Example: Pressing Tab inserts 2 spaces.

opt.expandtab = true -- Convert tabs to spaces
-- Example: Pressing Tab inserts spaces, not a literal tab character.

opt.smartindent = true -- Automatically inserts indents in some contexts
-- Example: After pressing Enter inside a function, new line is indented.

opt.autoindent = true -- Copy indent from previous line
-- Example: New line starts aligned with previous line.

opt.shiftround = true -- Round indent to nearest multiple of shiftwidth
-- Example: Indenting aligns neatly with multiples of 2 spaces.

-- Search
opt.ignorecase = true -- Ignore case when searching
-- Example: /hello matches "Hello" or "HELLO".

opt.smartcase = true -- Override ignorecase if search contains uppercase
-- Example: /Hello only matches "Hello", not "hello".

-- Mouse
opt.mouse = "a" -- Enable mouse in all modes
-- Example: You can click to move the cursor or resize splits.

-- Splits / windows
opt.splitbelow = true -- New horizontal splits go below
-- Example: :split opens new window below current.

opt.splitright = true -- New vertical splits go to the right
-- Example: :vsplit opens new window to the right.

opt.splitkeep = "screen" -- Keep screen position when splitting
-- Example: Cursor stays visually in place when split opens.

-- Undo / history
opt.undofile = true -- Save undo history to file
-- Example: Undo history persists even after closing Neovim.

opt.undolevels = 10000 -- Maximum number of undos
-- Example: You can undo many thousands of changes.

-- Timing
opt.timeoutlen = vim.g.vscode and 1000 or 300
-- Key sequence timeout in milliseconds
-- Example: Which-key triggers faster (300ms) except in VSCode.

opt.updatetime = 200 -- Update time in milliseconds for CursorHold, swap, etc.
-- Example: LSP diagnostics refresh quickly and swap file updates frequently.

-- Folding
opt.foldmethod = "indent" -- Fold based on indentation
-- Example: A function’s body can be folded if indented.

opt.foldlevel = 99 -- Open folds by default
-- Example: All folds appear expanded initially.

-- Editor behaviour / misc
opt.formatoptions = "jcroqlnt" -- Control formatting behaviour
-- Example: Auto-wrap comments, remove trailing spaces, etc.

opt.grepformat = "%f:%l:%c:%m" -- Format for grep results
-- Example: :grep output is parsed correctly for quickfix.

opt.grepprg = "rg --vimgrep" -- Use ripgrep for :grep
-- Example: :grep finds patterns faster than default grep.

opt.inccommand = "nosplit" -- Show live preview of substitutions
-- Example: :%s/foo/bar/g shows replacements as you type.

opt.jumpoptions = "view" -- Keep view when jumping
-- Example: Cursor jumps but scroll position stays.

opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
-- Example: :mksession restores buffers, folds, splits, etc.

opt.showmatch = true -- Highlight matching brackets
-- Example: Cursor on ( highlights the corresponding ).

-- opt.autoread = true -- Auto reload files changed outside Vim
-- Example: File edited by Git is automatically updated in buffer.

opt.confirm = true -- Ask before closing unsaved files
-- Example: :q prompts to save changes if buffer modified.

opt.virtualedit = "block" -- Allow cursor in virtual space (useful in visual block mode)
-- Example: Can select a rectangular block beyond text end.

opt.wildmode = "longest:full,full" -- Command-line completion behaviour
-- Example: Tab completes the longest match, then shows all options.

opt.smoothscroll = true -- Smooth scrolling instead of jumpy
-- Example: Cursor moves gradually when scrolling.

opt.spelllang = { "en" } -- Set spell check language
-- Example: :set spell uses English for corrections.

-- Shortmess: combine multiple flags
opt.shortmess:append({ s = true, I = true, W = true, c = true, C = true })
-- Example: Disable intro message, info, and completion messages.
