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
		timeout_ms = 1000,
		lsp_fallback = true,
	},
	-- Add error handling hooks for formatters
	-- format_after_save = function(bufnr)
	-- 	-- This function will run after formatting
	-- 	-- You can add custom logic here if needed
	-- 	-- if vim.bo[bufnr].filetype == "bash" or vim.bo[bufnr].filetype == "sh" then
	-- 	-- 	-- Add specific logic for bash files if needed
	-- 	-- end
	-- end,
}

return options
