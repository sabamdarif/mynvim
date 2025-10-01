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
-- map("n", "<leader>r", "<cmd>set rnu!<CR>", { desc = "Toggle relative number" })

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

-- ============  Terminal Mode =============
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Exit terminal mode" })

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
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

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
-- map("n", "<C-a>", function()
-- 	local pos = vim.fn.getpos(".") -- Save current cursor position
-- 	vim.cmd("normal! ggVG") -- Go to top and select all
-- 	-- After yanking with 'y', restore position
-- 	vim.api.nvim_create_autocmd("TextYankPost", {
-- 		callback = function()
-- 			vim.fn.setpos(".", pos)
-- 			return true -- Remove the autocmd after first use
-- 		end,
-- 		once = true,
-- 	})
-- end, { noremap = true, silent = true, desc = "Select all text and restore position after yank" })
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

-- ============  Commenting =============
map({ "n", "v" }, "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map({ "n", "v" }, "<C-/>", "gcc", { desc = "Toggle comment", remap = true })

-- ============ 󰆴 Normal Mode Delete Word (No Yank) =============
map({ "n", "v" }, "<Del>", '"_dw', { noremap = true, silent = true, desc = "Delete word (no yank)" })

-- ============  VS Code-Like Keybindings =============

map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Undo / Redo
map("i", "<C-z>", "<Esc>ua", { noremap = true, desc = "Undo in insert mode" })
map("n", "<C-z>", "u", { noremap = true, desc = "Undo" })

-- Redo (note: <C-r> is redo in normal mode)
map("i", "<C-S-z>", "<Esc><C-r>a", { noremap = true, desc = "Redo in insert mode" })
map("n", "<C-S-z>", "<C-r>", { noremap = true, desc = "Redo" })

-- Delete word
map("i", "<C-BS>", "<C-w>", { desc = "Delete previous word" })
map("i", "<C-Del>", "<C-o>dw", { desc = "Delete next word" })

-- Clipboard-like behavior
map("v", "<C-x>", '"+d', { noremap = true, desc = "Cut to clipboard" })
map("v", "<C-c>", '"+y', { noremap = true, desc = "Copy to clipboard" })
map("i", "<C-v>", "<C-r>+", { noremap = true, desc = "Paste clipboard" })
map("n", "<C-v>", '"+p', { noremap = true, desc = "Paste clipboard" })
-- vaf vif vai
