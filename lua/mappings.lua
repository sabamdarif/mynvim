---@diagnostic disable: undefined-global
local map = vim.keymap.set

-- ============  Insert Mode Navigation =============
map("i", "<C-b>", "<ESC>^i", { desc = "Move to beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Move to end of line" })
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })

-- ============  Window Navigation =============
map("n", "<C-h>", "<C-w>h", { desc = "Switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Switch window up" })

-- ============  Saving & Clipboard =============
map("i", "<C-s>", "<Esc><Cmd>write<CR>", { noremap = true, silent = true, desc = "Save and exit insert mode" })
map("n", "<C-s>", "<Cmd>write<CR>", { noremap = true, silent = true, desc = "Save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Copy whole file to clipboard" })

-- ============ 󰛔 Search, Replace & Highlight =============
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlights" })
map({ "n", "v" }, "<leader>sr", function()
	local grug = require("grug-far")
	local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
	grug.open({
		transient = true,
		prefills = {
			filesFilter = ext and ext ~= "" and "*." .. ext or nil,
		},
	})
end, { desc = "Search and Replace (grug-far)" })

-- ============  Line Number Toggle =============
map("n", "<leader>r", "<cmd>set rnu!<CR>", { desc = "Toggle relative number" })

-- ============  File Explorer =============
map({ "n", "v", "i" }, "<C-n>", "<cmd>NvimTreeToggle<CR>", { remap = true, desc = "Toggle NvimTree" })

-- ============  Telescope Mappings =============
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map(
	"n",
	"<leader>fa",
	"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
	{ desc = "Find all files" }
)
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Grep through files" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "List open buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "Jump to marks" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "Hidden terminals" })
map(
	"n",
	"<leader>f",
	"<cmd>Telescope current_buffer_fuzzy_find<CR>",
	{ desc = "Fuzzy search current buffer", noremap = true }
)
map("n", "<leader>th", function()
	require("telescope.builtin").colorscheme({ enable_preview = true })
end, { desc = "Choose colorscheme with preview" })

-- ============ 󰁨 Formatting =============
map({ "n", "x" }, "<leader>fm", function()
	require("conform").format({ lsp_fallback = true })
end, { desc = "Format file" })

-- ============  Commenting =============
map({ "n", "v" }, "<leader>/", "gcc", { desc = "Toggle comment", remap = true })

-- ============  Terminal Mode =============
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Exit terminal mode" })

-- ============  WhichKey =============
map("n", "<leader>wK", "<cmd>WhichKey<CR>", { desc = "Show all keymaps" })
map("n", "<leader>wk", function()
	vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
end, { desc = "WhichKey query" })

-- ============ 󰍽 Mouse Scrolling =============
for _, mode in ipairs({ "n", "v" }) do
	map(mode, "<ScrollWheelUp>", "<C-y>", { silent = true })
	map(mode, "<ScrollWheelDown>", "<C-e>", { silent = true })
	map(mode, "<S-ScrollWheelUp>", "<C-u>", { silent = true })
	map(mode, "<S-ScrollWheelDown>", "<C-d>", { silent = true })
end

-- ============  Plugin Tools =============
map("n", "<leader>lz", "<cmd>Lazy<CR>", { desc = "Open Lazy plugin manager" })

-- ============  Session & Notifications =============
map("n", "<leader>ql", function()
	require("persistence").load({ last = true })
end, { desc = "Restore last session" })
map("n", "<leader>n", "<cmd>NoiceDismiss<CR>", { noremap = true, desc = "Dismiss notifications" })
map("n", "<leader>N", "<cmd>Noice telescope<CR>", { noremap = true, desc = "Noice history" })

-- ============  Code Runner =============
map("n", "<leader>e", "<cmd>RunFile<CR>", { desc = "Run current file" })
map("n", "<leader>ep", "<cmd>RunProject<CR>", { desc = "Run entire project" })
map("n", "<leader>ec", "<cmd>RunClose<CR>", { desc = "Close runner" })

-- ============ 󱓧 Treesitter Context =============
map("n", "<leader>tc", function()
	local tsc = require("treesitter-context")
	tsc.toggle()
	if tsc.enabled then
		vim.notify("Enabled Treesitter Context", vim.log.levels.INFO, { title = "Option" })
	else
		vim.notify("Disabled Treesitter Context", vim.log.levels.WARN, { title = "Option" })
	end
end, { desc = "Toggle Treesitter Context" })

-- ============ 󰓩 Buffers & Tabs =============
map("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
map("n", "<leader>x", "<cmd>Bdelete!<CR>", { desc = "Close buffer", noremap = true, silent = true })

-- ============  Splits =============
map("n", "<leader>sv", "<cmd>vsp<cr>", { noremap = true, silent = true, desc = "Vertical split" })
map("n", "<leader>sh", "<cmd>sp<cr>", { noremap = true, silent = true, desc = "Horizontal split" })

-- ============  Git Integration =============
map("n", "dv", ":DiffviewOpen<CR>", { desc = "Open Git diff view" })
map("n", "<leader>dq", "DiffviewClose<CR>", { noremap = true, silent = true, desc = "Close Git diff view" })
map("n", "dh", ":DiffviewFileHistory %<CR>", { noremap = true, silent = true, desc = "File Git history" })
local ok, gs = pcall(require, "gitsigns")
if ok then
	map("n", "hp", gs.preview_hunk, { noremap = true, silent = true, desc = "Preview Git hunk" })
	map("n", "hr", gs.reset_hunk, { noremap = true, silent = true, desc = "Reset Git hunk" })
end

-- ============  Live Preview =============
local live_preview_running = false
map("n", "<leader>lp", function()
	if live_preview_running then
		vim.cmd("LivePreview close")
		live_preview_running = false
	else
		vim.cmd("LivePreview start")
		live_preview_running = true
	end
end, { noremap = true, desc = "Toggle Live Preview" })

-- ============ 󰒆 Select All =============
map("n", "<C-a>", "ggVG", { noremap = true, silent = true, desc = "Select all text" })

-- ============  Todo Comments =============
map("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next Todo Comment" })
map("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous Todo Comment" })
map("n", "<leader>xt", "<cmd>Trouble todo toggle<cr>", { desc = "Todo (Trouble)" })
map(
	"n",
	"<leader>xT",
	"<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>",
	{ desc = "Todo/Fix/Fixme (Trouble)" }
)
map("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Todo" })
map("n", "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", { desc = "Todo/Fix/Fixme" })
