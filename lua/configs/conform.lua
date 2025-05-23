local conform = require("conform")
local formatters_by_ft = require("custom.formatter")

local M = {}

M.formatters_by_ft = formatters_by_ft

M.format_on_save = {
	timeout_ms = 3000,
	-- If true the method won't block. Defaults to false. If the buffer is modified before the formatter completes, the formatting will be discarded.
	async = false,
	-- Don't show any notifications for warnings or failures. Defaults to false.
	quiet = false,
	-- Configure if and when LSP should be used for formatting. Defaults to "never".
	lsp_format = "fallback",
}
-- Set the log level. Use `:ConformInfo` to see the location of the log file.
M.log_level = vim.log.levels.ERROR
-- Conform will notify you when a formatter errors
M.notify_on_error = true
-- Conform will notify you when no formatters are available for the buffer
M.notify_no_formatters = true

M.format = function(buf)
	conform.format({ bufnr = buf })
end

M.sources = function(buf)
	local ret = conform.list_formatters(buf)
	return vim.tbl_map(function(v)
		return v.name
	end, ret)
end

return M
