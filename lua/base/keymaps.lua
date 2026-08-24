local map = vim.keymap.set

-- Insert mode navigation
map("i", "<C-b>", "<ESC>^i", { desc = "Beginning of line" })
map("i", "<C-e>", "<End>", { desc = "End of line" })
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })

-- Windows
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split vertically" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split horizontally" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Narrow window" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Widen window" })

-- Buffers
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
map("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- Files
map("n", "<C-s>", "<cmd>write<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc><cmd>write<CR>", { desc = "Save file" })
map({ "n", "v" }, "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
map("i", "<C-n>", "<Esc><cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

-- Search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", { desc = "Find all files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Fuzzy find in buffer" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "Marks" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Git status" })
map("n", "<leader>th", "<cmd>Telescope colorscheme enable_preview=true<CR>", { desc = "Colorschemes" })

-- Git hunks
map("n", "hp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
map("n", "hr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })

-- Format
map({ "n", "x" }, "<leader>fm", function()
    require("conform").format({ lsp_format = "fallback" })
end, { desc = "Format buffer" })

-- Run the current file / project (code_runner.nvim)
map("n", "<leader>e", "<cmd>RunFile<CR>", { desc = "Run file" })
map("n", "<leader>ep", "<cmd>RunProject<CR>", { desc = "Run project" })
map("n", "<leader>ec", "<cmd>RunClose<CR>", { desc = "Close runner" })

-- Markdown/HTML live preview (live-preview.nvim has no toggle command)
local previewing = false
map("n", "<leader>lp", function()
    previewing = not previewing
    vim.cmd("LivePreview " .. (previewing and "start" or "close"))
end, { desc = "Toggle live preview" })

-- Todo comments
map("n", "]t", function()
    require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
map("n", "[t", function()
    require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
map("n", "<leader>st", "<cmd>TodoTelescope<CR>", { desc = "Search todo comments" })

-- Plugin manager
map("n", "<leader>lz", "<cmd>Lazy<CR>", { desc = "Lazy" })

-- Terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Exit terminal mode" })

-- Comment (gcc is built in since 0.10)
map({ "n", "v" }, "<leader>/", "gcc", { remap = true, desc = "Toggle comment" })
map({ "n", "v" }, "<C-/>", "gcc", { remap = true, desc = "Toggle comment" })

-- Editor conveniences
-- `ggVG` parks the cursor on the last line, and yanking a visual selection then
-- jumps it to the start of the yank -- so plain <C-a>y lands you on line 1.
-- Remember where we were and go back once the selection is used or dropped.
map("n", "<C-a>", function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_create_autocmd("ModeChanged", {
        once = true,
        pattern = "[vV\22]*:n*", -- leaving any visual mode for normal mode
        callback = function()
            vim.schedule(function()
                pcall(vim.api.nvim_win_set_cursor, 0, pos)
            end)
        end,
    })
    return "ggVG"
end, { expr = true, desc = "Select whole file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Yank whole file" })
map("v", "<", "<gv", { desc = "Unindent and reselect" })
map("v", ">", ">gv", { desc = "Indent and reselect" })
map({ "n", "v" }, "<Del>", '"_dw', { desc = "Delete word without yanking" })

-- VS Code style undo / clipboard
map("n", "<C-z>", "u", { desc = "Undo" })
map("i", "<C-z>", "<Esc>ua", { desc = "Undo" })
map("n", "<C-S-z>", "<C-r>", { desc = "Redo" })
map("i", "<C-S-z>", "<Esc><C-r>a", { desc = "Redo" })
map("i", "<C-BS>", "<C-w>", { desc = "Delete previous word" })
map("i", "<C-Del>", "<C-o>dw", { desc = "Delete next word" })
map("v", "<C-x>", '"+d', { desc = "Cut to clipboard" })
map("v", "<C-c>", '"+y', { desc = "Copy to clipboard" })
map("i", "<C-v>", "<C-r>+", { desc = "Paste from clipboard" })
map("n", "<C-v>", '"+p', { desc = "Paste from clipboard" })

-- Mouse wheel scrolls the view instead of moving the cursor
for _, mode in ipairs({ "n", "v" }) do
    map(mode, "<ScrollWheelUp>", "<C-y>", { silent = true })
    map(mode, "<ScrollWheelDown>", "<C-e>", { silent = true })
    map(mode, "<S-ScrollWheelUp>", "<C-u>", { silent = true })
    map(mode, "<S-ScrollWheelDown>", "<C-d>", { silent = true })
end
