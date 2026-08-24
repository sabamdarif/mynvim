local au = vim.api.nvim_create_autocmd

local function augroup(name)
    return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Reload buffers changed outside nvim
au({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd.checktime()
        end
    end,
})

-- Flash yanked text
au("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Keep splits equally sized when the terminal is resized
au("VimResized", {
    group = augroup("resize_splits"),
    callback = function()
        local tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. tab)
    end,
})

-- Reopen a file where you left it
au("BufReadPost", {
    group = augroup("last_loc"),
    callback = function(ctx)
        if vim.bo[ctx.buf].filetype == "gitcommit" or vim.b[ctx.buf].user_last_loc then
            return
        end
        vim.b[ctx.buf].user_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(ctx.buf, '"')
        if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(ctx.buf) then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Throwaway windows: unlisted, and q closes them
au("FileType", {
    group = augroup("close_with_q"),
    pattern = { "checkhealth", "help", "lspinfo", "man", "notify", "qf", "Lazy", "Mason", "startuptime" },
    callback = function(ctx)
        vim.bo[ctx.buf].buflisted = false
        vim.keymap.set("n", "q", function()
            vim.cmd.close()
            pcall(vim.api.nvim_buf_delete, ctx.buf, { force = true })
        end, { buffer = ctx.buf, silent = true, desc = "Close window" })
    end,
})

-- Prose: wrap and spellcheck
au("FileType", {
    group = augroup("wrap_spell"),
    pattern = { "gitcommit", "markdown", "text" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Never conceal JSON quotes
au("FileType", {
    group = augroup("json_conceal"),
    pattern = { "json", "jsonc", "json5" },
    callback = function()
        vim.opt_local.conceallevel = 0
    end,
})

-- Create missing parent directories on save
au("BufWritePre", {
    group = augroup("auto_create_dir"),
    callback = function(ctx)
        if not ctx.match:match("^%w%w+:[\\/][\\/]") then
            vim.fn.mkdir(vim.fn.fnamemodify(vim.uv.fs_realpath(ctx.match) or ctx.match, ":p:h"), "p")
        end
    end,
})

-- nvim-tree holds a window open, which makes :q and :bd behave oddly: :q would
-- leave the tree as the last window, and :bd would try to close it. Treat the
-- tree as if it weren't there.
au({ "BufEnter", "QuitPre" }, {
    group = augroup("nvimtree_quit"),
    callback = function(ev)
        if not package.loaded["nvim-tree"] then
            return
        end
        local tree = require("nvim-tree.api").tree
        if not tree.is_visible() then
            return
        end

        local windows = 0
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_config(win).focusable then
                windows = windows + 1
            end
        end

        if ev.event == "QuitPre" and windows == 2 then
            -- Only the tree and one buffer left: quit for real.
            vim.cmd.qall()
        elseif ev.event == "BufEnter" and windows == 1 then
            -- :bd left only the tree. Cycle it so we land on the previous buffer
            -- (closing it directly would hit "E444: Cannot close last window").
            vim.defer_fn(function()
                tree.toggle({ find_file = true, focus = true })
                tree.toggle({ find_file = true, focus = false })
            end, 10)
        end
    end,
})
