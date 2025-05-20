local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		css = { "prettierd" },
		html = { "prettierd" },
		javascript = { "prettierd" },
		python = { "isort", "black" },
		bash = { "shfmt" },
		json = { "prettierd" },
		yaml = { "yamlfmt" },
	},
	format_on_save = {
		timeout_ms = 3000,
		-- If true the method won't block. Defaults to false. If the buffer is modified before the formatter completes, the formatting will be discarded.
		async = false, -- not recommended to change
		-- Don't show any notifications for warnings or failures. Defaults to false.
		quiet = false, -- not recommended to change
		-- Configure if and when LSP should be used for formatting. Defaults to "never".
		lsp_format = "fallback",
	},
	-- The options you set here will be merged with the builtin formatters.
	-- You can also define any custom formatters here.
	formatters = {
		injected = { options = { ignore_errors = true } },
		-- # Example of using dprint only when a dprint.json file is present
		-- dprint = {
		--   condition = function(ctx)
		--     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
		--   end,
		-- },
		--
		-- # Example of using shfmt with extra args
		-- shfmt = {
		--   prepend_args = { "-i", "2", "-ci" },
		-- },
	},
	-- Add error handling hooks for formatters
	-- format_after_save = function(bufnr)
	-- This function will run after formatting
	-- You can add custom logic here if needed
	-- if vim.bo[bufnr].filetype == "bash" or vim.bo[bufnr].filetype == "sh" then
	-- 	-- Add specific logic for bash files if needed
	-- end
	-- end,
}

return options
