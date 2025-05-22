local M = {}
function M.setup()
	local function augroup(name)
		return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
	end
	-- Reload file if changed outside Vim
	vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
		group = augroup("checktime"),
		callback = function()
			if vim.o.buftype ~= "nofile" then
				vim.cmd.checktime()
			end
		end,
	})
	-- Highlight on yank
	vim.api.nvim_create_autocmd("TextYankPost", {
		group = augroup("highlight_yank"),
		callback = function()
			(vim.hl or vim.highlight).on_yank()
		end,
	})
	-- Resize splits when Vim is resized
	vim.api.nvim_create_autocmd("VimResized", {
		group = augroup("resize_splits"),
		callback = function()
			local cur = vim.fn.tabpagenr()
			vim.cmd("tabdo wincmd =")
			vim.cmd("tabnext " .. cur)
		end,
	})
	-- Go to last edit position when opening a buffer
	vim.api.nvim_create_autocmd("BufReadPost", {
		group = augroup("last_loc"),
		callback = function(ctx)
			local exclude = { "gitcommit" }
			if vim.tbl_contains(exclude, vim.bo[ctx.buf].filetype) or vim.b[ctx.buf].user_last_loc then
				return
			end
			vim.b[ctx.buf].user_last_loc = true
			local mark = vim.api.nvim_buf_get_mark(ctx.buf, '"')
			local linecount = vim.api.nvim_buf_line_count(ctx.buf)
			if mark[1] > 1 and mark[1] <= linecount then
				pcall(vim.api.nvim_win_set_cursor, 0, mark)
			end
		end,
	})
	-- Close certain filetypes with <q>
	vim.api.nvim_create_autocmd("FileType", {
		group = augroup("close_with_q"),
		pattern = {
			"PlenaryTestPopup",
			"checkhealth",
			"dbout",
			"gitsigns-blame",
			"grug-far",
			"help",
			"lspinfo",
			"neotest-output",
			"neotest-output-panel",
			"neotest-summary",
			"notify",
			"qf",
			"Lazy",
			"Mason",
			"spectre_panel",
			"startuptime",
			"tsplayground",
		},
		callback = function(ctx)
			vim.bo[ctx.buf].buflisted = false
			vim.keymap.set("n", "q", function()
				vim.cmd.close()
				pcall(vim.api.nvim_buf_delete, ctx.buf, { force = true })
			end, { buffer = ctx.buf, silent = true, desc = "Quit buffer" })
		end,
	})
	-- Make man pages unlisted
	vim.api.nvim_create_autocmd("FileType", {
		group = augroup("man_unlisted"),
		pattern = "man",
		callback = function(ctx)
			vim.bo[ctx.buf].buflisted = false
		end,
	})
	-- Wrap & spellcheck in text-like filetypes
	vim.api.nvim_create_autocmd("FileType", {
		group = augroup("wrap_spell"),
		pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
		callback = function()
			vim.opt_local.wrap = true
			vim.opt_local.spell = true
		end,
	})
	-- Disable conceal for JSON
	vim.api.nvim_create_autocmd("FileType", {
		group = augroup("json_conceal"),
		pattern = { "json", "jsonc", "json5" },
		callback = function()
			vim.opt_local.conceallevel = 0
		end,
	})
	-- Auto-create missing directories on save
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = augroup("auto_create_dir"),
		callback = function(ctx)
			if ctx.match:match("^%w%w+:[\\/][\\/]") then
				return
			end
			local file = vim.loop.fs_realpath(ctx.match) or ctx.match
			vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
		end,
	})

	-- Auto-switch to normal mode when entering NvimTree or neo-tree
	vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
		group = augroup("tree_normal_mode"),
		callback = function(ctx)
			local tree_filetypes = { "NvimTree", "neo-tree", "nerdtree" }

			if vim.tbl_contains(tree_filetypes, vim.bo[ctx.buf].filetype) then
				-- If we're in insert mode, escape to normal mode
				if vim.fn.mode() ~= "n" then
					vim.cmd("stopinsert")
					-- Using a vim.schedule here to ensure mode change happens after autocmd completes
					vim.schedule(function()
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
					end)
				end
			end
		end,
	})
end
-- Autocmd to refresh highlight when colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#3b4261", nocombine = true })
	end,
})
return M
