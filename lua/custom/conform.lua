return {
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
	-- Set the log level. Use `:ConformInfo` to see the location of the log file.
	log_level = vim.log.levels.ERROR,
	-- Conform will notify you when a formatter errors
	notify_on_error = true,
	-- Conform will notify you when no formatters are available for the buffer
	notify_no_formatters = true,
	-- The options you set here will be merged with the builtin formatters.
	-- You can also define any custom formatters here.
}
