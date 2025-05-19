local map = vim.keymap.set

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

-- Save from insert mode and stay in normal mode
map("i", "<C-s>", "<Esc><Cmd>write<CR>", { noremap = true, silent = true, desc = "Save and exit insert mode" })
-- Save in normal-mode
map("n", "<C-s>", "<Cmd>write<CR>", { noremap = true, silent = true, desc = "Save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

map("n", "<leader>r", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
-- map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })
map("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "toggle Lazy plugin manager" })

map({ "n", "x" }, "<leader>fm", function()
	require("conform").format({ lsp_fallback = true })
end, { desc = "general format file" })

-- global lsp mappings
map("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", {})
map("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", {})
map("n", "<leader>x", "<cmd>Bdelete!<CR>", { desc = "buffer close", noremap = true, silent = true })
-- Comment
map({ "n", "v" }, "<leader>/", "gcc", { desc = "Toggle comment", remap = true })

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })

-- telescope
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Grep through files" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map(
	"n",
	"<leader>f",
	"<cmd>Telescope current_buffer_fuzzy_find<CR>",
	{ desc = "Fuzzy search in current buffer", noremap = true }
)
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files", noremap = true })
map(
	"n",
	"<leader>fa",
	"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
	{ desc = "telescope find all files" }
)
map("n", "<leader>th", "<cmd>Telescope colorscheme<CR>", { desc = "telescope git commits" })

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
	vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
end, { desc = "whichkey query lookup" })
for _, mode in ipairs({ "n", "v" }) do
	map(mode, "<ScrollWheelUp>", "<C-y>", { silent = true })
	map(mode, "<ScrollWheelDown>", "<C-e>", { silent = true })
	map(mode, "<S-ScrollWheelUp>", "<C-u>", { silent = true })
	map(mode, "<S-ScrollWheelDown>", "<C-d>", { silent = true })
end

-- Insert: wrap <C-y>/<C-e>/<C-u>/<C-d> in a normal! to keep you in insert mode
map("i", "<ScrollWheelUp>", "<Cmd>normal! <C-y><CR>", { silent = true })
map("i", "<ScrollWheelDown>", "<Cmd>normal! <C-e><CR>", { silent = true })
map("i", "<S-ScrollWheelUp>", "<Cmd>normal! <C-u><CR>", { silent = true })
map("i", "<S-ScrollWheelDown>", "<Cmd>normal! <C-d><CR>", { silent = true })
-- serach and replace
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
map("n", "<leader>n", "<cmd>NoiceDismiss<CR>", { noremap = true, desc = "Dismiss Noice notifications" })
-- Run current file
map("n", "<leader>e", "<cmd>RunFile<CR>", { desc = "Run current file" })
map("n", "<leader>ep", "<cmd>RunProject<CR>", { desc = "Run project" })
map("n", "<leader>ec", "<cmd>RunClose<CR>", { desc = "Close runner" })
map("n", "<leader>tc", function()
	local tsc = require("treesitter-context")
	tsc.toggle()
	if tsc.enabled then
		vim.notify("Enabled Treesitter Context", vim.log.levels.INFO, { title = "Option" })
	else
		vim.notify("Disabled Treesitter Context", vim.log.levels.WARN, { title = "Option" })
	end
end, { desc = "Toggle Treesitter Context" })
-- load the last session
vim.keymap.set("n", "<leader>ql", function()
	require("persistence").load({ last = true })
end)
